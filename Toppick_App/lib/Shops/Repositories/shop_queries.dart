import 'dart:convert';
import 'package:Toppick_App/Shops/Models/horario.dart';
import 'package:http/http.dart' as http;
import '../Models/tienda.dart';

class ShopQueries {
  int port = 3000;
  Future<List<Tienda>> getAllAvailableShops() async{
    List<Tienda> queryResult = [];
    final response = await http.get(Uri.http('10.0.2.2:$port','toppick/app/all-stores'), headers: {"Accept": "application/json"});
    if (response.statusCode == 200) {
      queryResult = parseShops(response.body);
      return queryResult;
    } else { 
      throw Exception('Error');
    }
  }

  /*List<Horario> schedule = [
      Horario(TimeOfDay(hour: 6, minute: 0),TimeOfDay(hour: 21, minute: 0), ["Lunes", "Martes", "Miércoles", "Jueves", "Viernes"]),
      Horario(TimeOfDay(hour: 8, minute: 0),TimeOfDay(hour: 16, minute: 0), ["Sábado", "Domingo"]),
    ];
    List<Horario> schedule2 = [
      Horario(TimeOfDay(hour: 4, minute: 0),TimeOfDay(hour: 22, minute: 0), ["Lunes", "Martes", "Miércoles", "Jueves", "Viernes"]),
      Horario(TimeOfDay(hour: 8, minute: 0),TimeOfDay(hour: 16, minute: 0), ["Sábado", "Domingo"]),
    ]; */

  

  Tienda getShopById(int id) /*async*/ {
    Tienda queryResult;
    /*
    final response =await http.get('https://');
    if (response.statusCode == 200) {
        //the call to the server was successful, 
        Iterable l = json.decode(response.body);
        List<Tienda> queryResult = List<Post>.from(l.map((model)=> Post.fromJson(model))); 
    } else {
    
        throw Exception('Failed to load post');
        }
    */
    queryResult = Tienda(
      1,
      "La Central",
      "Cafeterías",
      "En el restaurante La Central brindamos gran variedad de productos: desayunos, almuerzos, comidas rápidas, pizzas, opciones para llevar y un espacio cómodo, una experiencia única.",
      "assets/img/central.PNG",
      "Abierto",
      "https://www.google.com/maps/dir//la+central+javeriana/data=!4m6!4m5!1m1!4e2!1m2!1m1!1s0x8e3f9b5f5fdde08f:0x19a674df1df81bae?sa=X&ved=2ahUKEwiBnN-jyKnvAhVju1kKHewoCP4Q9RcwAHoECAQQAw",
    );
    
    return queryResult;
  }

  Future<List<Tienda>> getAvailableShopsByProduct(int productId) async {
    List<Tienda> queryResult = [];
    final response = await http.get(Uri.http('10.0.2.2:$port','/toppick/app/stores-that-contains/$productId'), headers: {"Accept": "application/json"});
    if (response.statusCode == 200) {
      queryResult = parseShops(response.body);
      return queryResult;
    } else { 
      throw Exception('Error');
    }
  }

  Future<List<Horario>> getShopSchedule(int id) async {
    List<Horario> queryResult = [];
    final response = await http.get(Uri.http('10.0.2.2:$port','/toppick/app/schedule/for/store/$id'), headers: {"Accept": "application/json"});
    if (response.statusCode == 200) {
      queryResult = parseSchedules(response.body);
      return queryResult;
    } else { 
      throw Exception('Error');
    }
  }

  List<Tienda> parseShops(String responseBody) {
    List<Tienda> result = [];
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    for(var val in parsed){
      result.add(Tienda.fromJson(val));
    }
    return result;
  }

  List<Horario> parseSchedules(String responseBody){
    List<Horario> result = [];
    List<String> days1 = [];
    List<String> days2 = [];
    int cont = 0;
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    //Primera linea son los que tienen horario de día completo, los otros los que solo tienen horario entre semana
    bool fullDay = (parsed[0]['idPuntoDeVenta'] == 2 || parsed[0]['idPuntoDeVenta'] == 8 || parsed[0]['idPuntoDeVenta'] == 10
    || parsed[0]['idPuntoDeVenta'] == 5 || parsed[0]['idPuntoDeVenta'] == 15 || parsed[0]['idPuntoDeVenta'] == 21
    || parsed[0]['idPuntoDeVenta'] == 22 || parsed[0]['idPuntoDeVenta'] == 23);
    for(var val in parsed){
      if(fullDay){
        days1.add(val['nombreDia']);
        if(cont==0){
          result.add(Horario.fromJson(val));
          cont++;
        }
      }else{
        if(val['nombreDia']!="Sábado"){
          days1.add(val['nombreDia']);
          if(cont==0){
            result.add(Horario.fromJson(val));
            cont++;
          }
        }else{
          days2.add(val['nombreDia']);
          result.add(Horario.fromJson(val));
        }
      }
    }
    if(fullDay){
      result[0].dias = days1;
    }
    else{
      result[0].dias = days1;
      result[1].dias = days2;
    }
    return result;
  }
}
