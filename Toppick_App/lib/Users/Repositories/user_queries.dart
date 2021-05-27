import 'dart:convert';

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
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        "nombreUsuario": user.correo,
        "contraseña": user.password,
        "nombreCompleto" : user.nombres+" "+user.apellidos,
        "tipoDocumento": user.tipoDocumento,
        "idDocumento": user.documento,
        "token": PushNotificationService.token,
        "celular": user.celular
      })
    );
    print(response.body);
    print(response.statusCode);
    if(response.statusCode == 200){
      String? cookie = response.headers['set-cookie'];
      if(cookie != null){
        int index = cookie.indexOf(";");
        String finalCookie = "";
        (index == -1)? finalCookie = cookie : finalCookie = cookie.substring(0, index);
        prefs.setString('cookie', finalCookie);
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
}