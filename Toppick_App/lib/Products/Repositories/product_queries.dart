import 'package:Toppick_App/Products/Models/a_la_carta.dart';
import 'package:Toppick_App/Products/Models/acompanamiento.dart';
import 'package:Toppick_App/Products/Models/bebida.dart';
import 'package:Toppick_App/Products/Models/desayuno.dart';
import 'package:Toppick_App/Products/Models/empaquetados.dart';
import 'package:Toppick_App/Products/Models/especialidad.dart';
import 'package:Toppick_App/Products/Models/otros.dart';

import '../Models/combo.dart';
import '../Models/producto.dart';

class ProductQueries {
  List<dynamic> getAllAvailableProducts() /*async*/ {
    List<dynamic> queryResult = [];
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

    List<Acompanamiento> ingredients = [
      Acompanamiento(1, "Tomate", false),
      Acompanamiento(2, "Cebolla", false),
      Acompanamiento(3, "Aguacate", false),
      Acompanamiento(4, "Cilantro", false),
      Acompanamiento(5, "Carne de res", true),
      Acompanamiento(6, "Pan", true),
    ];

    List<dynamic> productList = [];
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
      Bebida(50, "Tés", 3, "Té", 2000, 0, 4.5, "URL", "Bebidas"),
      Bebida(100, "Lácteos", 4, "Avena", 1200, 0, 4.5, "URL", "Bebidas"),
      Empaquetado(100, "Ponqués", 5, "Chocorramo", 2000, 0, 4.5, "URL", "Empaquetados"),
      Combo(
          productList,
          "Pescadito con carne y té",
          6,
          "Combo 1",
          3000,
          20,
          4.5,
          "URL",
          "Combos"),
      Especialidad(DateTime.now(), DateTime.now(), "Hamburguesa rica.", ingredients, 7, "Hamburguesa", 10000, 20, 4.5, "URL", "Especialidades"),
      Desayuno(DateTime.now(), DateTime.now(), "Huevos", 8, "Huevos revueltos", 5000, 10, 4.5, "URL", "Desayunos"),
    ];
    return queryResult;
  }

  List<Combo> getAllAvailableComboProducts() /*async*/ {
    List<Combo> queryResult = [];
    List<Producto> productList = [];
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
          productList,
          "Hojaldre relleno de arequipe, preparado por los mejores cocineros de toda la universidad.",
          1,
          "Pescadito",
          3000,
          20,
          4.5,
          "URL",
          "Combos"),
      Combo(
          productList,
          "Hojaldre relleno de arequipe, preparado por los mejores cocineros de toda la universidad.",
          2,
          "Pescadito",
          3000,
          20,
          4.5,
          "URL",
          "Combos"),
      Combo(
          productList,
          "Hojaldre relleno de arequipe, preparado por los mejores cocineros de toda la universidad.",
          3,
          "Pescadito",
          3000,
          20,
          4.5,
          "URL",
          "Combos"),
    ];
    return queryResult;
  }

  List<dynamic> getProductCatalogueById(int storeId) /*async*/ {
    List<dynamic> queryResult = [];
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
    List<Acompanamiento> ingredients = [
      Acompanamiento(1, "Tomate", false),
      Acompanamiento(2, "Cebolla", false),
      Acompanamiento(3, "Aguacate", false),
      Acompanamiento(4, "Cilantro", false),
      Acompanamiento(5, "Carne de res", true),
      Acompanamiento(6, "Pan", true),
    ];

    List<dynamic> productList = [];
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
      Bebida(50, "Tés", 3, "Té", 2000, 0, 4.5, "URL", "Bebidas"),
      Bebida(100, "Lácteos", 4, "Avena", 1200, 0, 4.5, "URL", "Bebidas"),
      Empaquetado(100, "Ponqués", 5, "Chocorramo", 2000, 0, 4.5, "URL", "Empaquetados"),
      Combo(
          productList,
          "Pescadito con carne y té",
          6,
          "Combo 1",
          3000,
          20,
          4.5,
          "URL",
          "Combos"),
      Especialidad(DateTime.now(), DateTime.now(), "Hamburguesa rica.", ingredients, 7, "Hamburguesa", 10000, 20, 4.5, "URL", "Especialidades"),
      Desayuno(DateTime.now(), DateTime.now(), "Huevos", 8, "Huevos revueltos", 5000, 10, 4.5, "URL", "Desayunos"),
    ];
    return queryResult;
  }

  dynamic getProductById(int id) /*async*/ {
    dynamic queryResult;
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
    queryResult = Otros("Horneado", 1, "Pescadito", 3000, 20, 4.5, "URL", "Otros");
    return queryResult;
  }
}
