import 'dart:convert';

import 'package:Toppick_App/Orders/Models/daviplata.dart';
import 'package:Toppick_App/Orders/Models/nequi.dart';
import 'package:Toppick_App/Orders/Models/pse.dart';
import 'package:Toppick_App/Services/push_notifications_service.dart';
import 'package:Toppick_App/Users/Models/cliente.dart';
import 'package:http/http.dart' as http;

class UserQueries{
  String domain = 'toppickapp.herokuapp.com';

  Future<bool> login(String email, String password, dynamic prefs) async {
    final response = await http.post(
      Uri.https(this.domain,'/usuarios/login'),
      headers: {"Accept": "application/json"},
      body: {
        "nombreUsuario":email,
        "contraseña":password,
        "token": PushNotificationService.token
      }
    );
    if(response.statusCode == 200){
      String? cookie = response.headers['set-cookie'];
      if(cookie != null){
        int index = cookie.indexOf(";");
        String finalCookie = "";
        (index == -1)? finalCookie = cookie : finalCookie = cookie.substring(0, index);
        prefs.setString('cookie', finalCookie);
        prefs.setString('correo', email);
        prefs.setString('password', password);
        final first = json.decode(response.body);
        final parsed = first['body'];
        String nombre = parsed['name'].split(" ")[0];
        prefs.setString('nombre', nombre);
        return true;
      }
      else{
        print("False por cookie");
        return false;
      }
    }else{
      print("False por error en peticion");
      return false;
    }
  }

  Future<bool> register(dynamic prefs, Cliente user) async {
    final response = await http.post(
      Uri.https(this.domain, '/usuarios'),
      headers: {"Accept": "application/json"},
      body:{
        "nombreUsuario": user.correo,
        "contraseña": user.password,
        "nombreCompleto" : user.nombreCompleto,
        "tipoDocumento": user.tipoDocumento,
        "idDocumento": user.documento.toString(),
        "token": PushNotificationService.token,
        "celular": user.celular.toString()
      }
    );
    if(response.statusCode == 200){
      String? cookie = response.headers['set-cookie'];
      if(cookie != null){
        int index = cookie.indexOf(";");
        String finalCookie = "";
        (index == -1)? finalCookie = cookie : finalCookie = cookie.substring(0, index);
        prefs.setString('cookie', finalCookie);
        prefs.setString('correo', user.correo);
        prefs.setString('password', user.password);
        print("Cookie: ${prefs.getString('cookie')}");
        return true;
      }
      else{
        print("False por cookie");
        return false;
      }
    }else{
      print("False por error en peticion");
      return false;
    }
  }
  
  Future<bool> logout(dynamic prefs) async {
    final response = await http.get(
      Uri.https(this.domain, '/usuarios/logout'),
      headers: {"Accept": "application/json", "Cookie":prefs.getString('cookie')}
    );
    if(response.statusCode == 200){
      return true;
    }else{
      return false;
    }
  }

  Future<Cliente> getUserInfo(String cookie, String email) async{
    final response = await http.get(
      Uri.https(this.domain, '/usuarios/perfil'),
      headers: {"Accept": "application/json", "Cookie": cookie}
    );
    if(response.statusCode == 200){
      final first = json.decode(response.body);
      final parsed = first['body'];
      Cliente result = Cliente.fromJson(parsed);
      result.correo = email;
      return result;
    }else{
      throw Exception('Error');
    }
  }

  Future<bool> updateUserInfo(String cookie, String nName, String nType, String document, String number) async {
    final response = await http.patch(
      Uri.https(this.domain, '/usuarios'),
      headers: {"Accept": "application/json", "Cookie": cookie},
      body:{
        "nombreCompleto": nName,
        "tipoDocumento": nType,
        "idDocumento": document,
        "celular": number,
      }
    );
    if(response.statusCode == 200){
      return true;
    }else{
      return false;
    }
  }

  Future<List<dynamic>> getPaymentMethods(String cookie) async{
    final response = await http.get(
      Uri.https(this.domain, '/pagos'),
      headers: {"Accept": "application/json", "Cookie": cookie}
    );
    if(response.statusCode == 200){
      return parsePaymentMethods(response.body);
    }else{
      return [];
    }
  }

  Future<bool> registerPaymentMethod(String cookie, String number, String name) async{
    int value = 300000;
    int numberV = int.parse(number);
    var myJson = jsonEncode({
        "metodo":{"saldoTotal":value},
        "opcionSeleccionada":{
          "opcion": name,
          "identificador": numberV
        }
      });
      print(myJson);
    final response = await http.post(
      Uri.https(this.domain, '/pagos'),
      headers: {"Accept": "application/json", "Cookie": cookie, "content-type": "application/json"},
      body: myJson
    );
    print(response.body);
    if(response.statusCode == 200){
      return true;
    }else{
      return false;
    }
  }

  Future<bool> updatePaymentMethod(String cookie, String methodName, int id, int toAdd, int current) async{
    int add = current+toAdd;
    final response = await http.patch(
      Uri.https(this.domain, '/pagos'),
      headers: {"Accept": "application/json", "Cookie": cookie, "content-type": "application/json"},
      body:jsonEncode({
        "metodo": methodName,
        "identificador": id,
        "saldo": add
      })
    );
    if(response.statusCode==200){
      return true;
    }else{
      return false;
    }
  }

  List<dynamic> parsePaymentMethods(String responseBody){
    List<dynamic> result = [];
    final first = json.decode(responseBody);
    print(first);
    int saldoTotal = 0;
    if(!first['body']['saldoTotal'].isEmpty){
      saldoTotal = first['body']['saldoTotal'][0]['saldoTotal'];
    }
    if(!first['body']['daviplata'].isEmpty){
      result.add(DaviPlata(0, saldoTotal, first['body']['daviplata'][0]['numeroCelular']));
    }
    if(!first['body']['nequi'].isEmpty){
      result.add(Nequi(0, saldoTotal, first['body']['nequi'][0]['numeroCelular']));
    }
    if(!first['body']['pse'].isEmpty){
      result.add(PSE(0, saldoTotal, first['body']['pse'][0]['numeroCuenta']));
    }
    return result;
  }
}