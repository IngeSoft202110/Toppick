import 'dart:convert';
import 'package:Toppick_App/Shops/Models/horario.dart';
import 'package:http/http.dart' as http;
import '../Models/tienda.dart';

class ShopQueries {
  int port = 3000;
  String domain = 'toppickapp.herokuapp.com';
  
  Future<List<Tienda>> getAllAvailableShops(String cookie) async{
    final response = await http.get(
      Uri.https(domain, '/tienda'),
      headers: {"Accept": "application/json", "Cookie":cookie}
    );
    if (response.statusCode == 200) {
      return parseShops(response.body);
    } else { 
      throw Exception('Error');
    }
  }

  Future<List<Tienda>> getAvailableShopsByProduct(int productId, String cookie) async {
    final response = await http.get(
      Uri.https(domain, '/tienda/producto/$productId'),
      headers: {"Accept": "application/json", "Cookie":cookie}
    );
    if (response.statusCode == 200) {
      return parseShops(response.body);
    } else { 
      throw Exception('Error');
    }
  }

  Future<List<Horario>> getShopSchedule(int id, String cookie) async {
    final response = await http.get(
      Uri.https(domain, '/tienda/horario/$id'),
      headers: {"Accept": "application/json", "Cookie":cookie}
    );
    if (response.statusCode == 200) {
      return parseSchedules(response.body, id);
    } else { 
      throw Exception('Error');
    }
  }

  List<Tienda> parseShops(String responseBody) {
    List<Tienda> result = [];
    final first = json.decode(responseBody);
    final parsed = first['body'];
    for(var val in parsed){
      if(val['Estado'] == "Abierto"){
        Tienda x = Tienda.fromJson(val);
        result.add(x);
      }
    }
    return result;
  }

  List<Horario> parseSchedules(String responseBody, int id){
    List<Horario> result = [];
    List<String> days1 = [];
    List<String> days2 = [];
    int cont = 0;
    final first = json.decode(responseBody);
    final parsed = first['body'];
    //Primera linea son los que tienen horario de día completo, los otros los que solo tienen horario entre semana
    bool fullDay = (id == 2 || id == 8 || id == 10 
      || id == 5 || id == 15 || id == 21 || id == 22 || id == 23);
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
