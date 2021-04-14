import 'dart:convert';
import 'package:Toppick_App/Products/Models/acompanamiento.dart';
import 'package:Toppick_App/Products/Models/combo.dart';
import 'package:Toppick_App/Products/Models/especialidad.dart';
import 'package:Toppick_App/Products/Models/producto.dart';
import 'package:http/http.dart' as http;


class ProductQueries {

  Future<List<dynamic>> getAllAvailableProducts() async {
    final response = await http.get(Uri.http('10.0.2.2:8001','toppick/app/products'), headers: {"Accept": "application/json"});
    if (response.statusCode == 200) {
        return parseProducts(response.body);
    } else { 
        throw Exception('Error');
    }
  } 

  List<Combo> getAllAvailableComboProducts() /*async*/ {
    List<Combo> queryResult = [];
    /*List<Producto> productList = [];
    /*
    final response =await http.get('https://');
    if (response.statusCode == 200) {
        //the call to the server was successful, 
        Iterable l = json.decode(response.body);
        List<Producto> queryResult = List<Post>.from(l.map((model)=> Post.fromJson(model)));  aqi antes de toca mirar que tipo de producto es
    } else {
    
        throw Exception('Failed to load post');
        }
    */
    productList = [
      Otros("Horneado", 1, "Pescadito", 3000, 20, 4.5, "URL", "Otros"),
      ALaCarta(
          "Carnes",
          2,
          "Baby Beaf",
          10000,
          20,
          4.5,
          "URL",
          "A la carta"),
      Bebida(50, "Tés", 3, "Té", 2000, 20, 4.5, "URL", "Bebidas"),
    ];
    queryResult = [
      Combo(
          "Hojaldre relleno de arequipe, preparado por los mejores cocineros de toda la universidad.",
          1,
          "Pescadito",
          3000,
          20,
          4.5,
          "URL",
          "Combos"),
      Combo(
          "Hojaldre relleno de arequipe, preparado por los mejores cocineros de toda la universidad.",
          2,
          "Pescadito",
          3000,
          20,
          4.5,
          "URL",
          "Combos"),
      Combo(
          "Hojaldre relleno de arequipe, preparado por los mejores cocineros de toda la universidad.",
          3,
          "Pescadito",
          3000,
          20,
          4.5,
          "URL",
          "Combos"),
    ];*/
    return queryResult;
  }

  Future<List<dynamic>> getProductCatalogueById(int storeId) async {
    final response = await http.get(Uri.http('10.0.2.2:8001','toppick/app/catalog/$storeId'), headers: {"Accept": "application/json"});
    if (response.statusCode == 200) {
        return parseProducts(response.body);
    } else { 
        throw Exception('Error');
    }
  }

  Future<List<dynamic>> getComboProducts(int comboId) async{
    final response = await http.get(Uri.http('10.0.2.2:8001','toppick/app/products-of-combo/$comboId'), headers: {"Accept": "application/json"});
    if (response.statusCode == 200) {
        return parseProducts(response.body);
    } else { 
        throw Exception('Error');
    }
  }

  Future<List<Acompanamiento>> getAditionsOfProduct(int idProduct) async{
    final response = await http.get(Uri.http('10.0.2.2:8001','toppick/app/accompaniment-of-specialty/$idProduct'), headers: {"Accept": "application/json"});
    if (response.statusCode == 200) {
        return parseAditions(response.body);
    } else { 
        throw Exception('Error');
    }
  }

  List<dynamic> parseProducts(String responseBody) { 
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    List<dynamic> x = [];
    for (var y in parsed) {
      String val = y['categoria'];
      if(val == 'Especialidades'){
        dynamic a = Especialidad.fromJson(y);
        x.add(a);
      }else if (val == 'Combos'){
          dynamic a = Combo.fromJson(y);
          x.add(a);
      }else{
        dynamic a = Producto.fromJson(y);
        x.add(a);
      }
    }
    return x; 
  }

  List<Acompanamiento> parseAditions(String responseBody){
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    List<Acompanamiento> aditions = [];
    for(var val in parsed){
      aditions.add(Acompanamiento.fromJson(val));
    }
    return aditions;
  }
}
