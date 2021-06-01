import 'dart:convert';
import 'package:Toppick_App/Products/Models/acompanamiento.dart';
import 'package:Toppick_App/Products/Models/combo.dart';
import 'package:Toppick_App/Products/Models/especialidad.dart';
import 'package:Toppick_App/Products/Models/producto.dart';
import 'package:http/http.dart' as http;


class ProductQueries {
  String domain = 'toppickapp.herokuapp.com';

  Future<List<dynamic>> getAllAvailableProducts(String cookie) async {
    final response = await http.get(
      Uri.https(this.domain, '/productos'),
      headers: {"Accept": "application/json", "Cookie":cookie}
    );
    if (response.statusCode == 200) {
        return parseProducts(response.body);
    } else { 
        throw Exception('Error');
    }
  } 

  Future<List<dynamic>> getProductCatalogueById(int storeId, String cookie) async {
    final response = await http.get(
      Uri.https(this.domain, '/tienda/catalogo/$storeId'),
      headers: {"Accept": "application/json", "Cookie":cookie}
    );
    if (response.statusCode == 200) {
        return parseProducts(response.body);
    } else { 
        throw Exception('Error');
    }
  }

  Future<List<dynamic>> getComboProducts(int comboId, String cookie) async{
    final response = await http.get(
      Uri.https(this.domain, '/productos/combo/$comboId'),
      headers: {"Accept": "application/json", "Cookie":cookie}
    );
    if (response.statusCode == 200) {
        return parseProducts(response.body);
    } else { 
        throw Exception('Error');
    }
  }

  Future<List<Acompanamiento>> getAditionsOfProduct(int idProduct, String cookie) async{
    final response = await http.get(
      Uri.https(this.domain, '/productos/acompanamientos/$idProduct'),
      headers: {"Accept": "application/json", "Cookie":cookie}
    );
    if (response.statusCode == 200) {
        return parseAditions(response.body);
    } else { 
        throw Exception('Error');
    }
  }

  List<dynamic> parseProducts(String responseBody) { 
    final first = json.decode(responseBody);
    final parsed = first['body'];
    List<dynamic> result = [];
    for (var y in parsed) {
      String val = y['categoria'];
      if(val == 'Especialidades'){
        dynamic a = Especialidad.fromJson(y);
        result.add(a);
      }else if (val == 'Combos'){
        dynamic a = Combo.fromJson(y);
        result.add(a);
      }else{
        if(y['precio']!=0){
          dynamic a = Producto.fromJson(y);
          result.add(a);
        }
      }
    }
    return result; 
  }

  List<Acompanamiento> parseAditions(String responseBody){
    final first = json.decode(responseBody);
    final parsed = first['body'];
    List<Acompanamiento> aditions = [];
    for(var val in parsed){
      aditions.add(Acompanamiento.fromJson(val));
    }
    return aditions;
  }
}
