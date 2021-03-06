import 'package:Toppick_App/Products/Models/acompanamiento.dart';
import 'package:flutter/material.dart';

import '../Models/producto.dart';
import '../Repositories/product_queries.dart';

class ProductController {
  ProductQueries productqueries = new ProductQueries();
  List<String> categories = [
    'Especialidades',
    'Desayunos',
    'Comida Rápida',
    'Parrilla',
    'Frutería',
    'Bebidas',
    'A la Carta',
    'Empaquetados',
    'Combos',
    'Otros',
  ];
  List<String> descriptions = [
    'Productos especializados de la universidad.', //Especialidades
    'Desayunos de la universidad.', //Desayunos
    'Comidas rápidas de la universidad.', //Comida rápida
    'Productos a la parrilla.', //Parrilla
    'Productos de las fruterías de la universidad.', //Frutería
    'Bebidas naturales, frías y calientes.', //Bebidas
    'Productos de la carta de la universidad.', //A la carta
    'Productos Empaquetados.', //Empaquetados
    'Combo de productos.', //Combos
    'Productos que no cumplen con las caracteristicas de los demás.',//Otros
  ];
  List<String> logoPahts = [
    'assets/icons/especialidad.png',
    'assets/icons/desayunos.png',
    'assets/icons/comidarapida.png',
    'assets/icons/parrilla.png',
    'assets/icons/fruteria.png',
    'assets/icons/bebidas.png',
    'assets/icons/alacarta.png',
    'assets/icons/empaquetados.png',
    'assets/icons/combos.png',
    'assets/icons/otros.png',
  ];

  ProductController() {
    this.productqueries = new ProductQueries();
  }

  Future<List<dynamic>> getAllAvailableProducts(String cookie) async{
    return await this.productqueries.getAllAvailableProducts(cookie);
  }

  Future<List<dynamic>> getProductCatalogueById(int storeId, String cookie) async {
    return await this.productqueries.getProductCatalogueById(storeId, cookie);
  }

  Future<List<dynamic>> getComboProducts(int comboId, String cookie){
    return this.productqueries.getComboProducts(comboId, cookie);
  }

  Future<List<Acompanamiento>> getAditionsOfProduct(int idProduct, String cookie){
    return this.productqueries.getAditionsOfProduct(idProduct, cookie);
  }

  List<String> getProductCategories(){
    return this.categories;
  }

  List<String> getCategoryDescription(){
    return this.descriptions;
  }

  List<String> getCategoryImagePath(){
    return this.logoPahts;
  }

  List<dynamic> filterProducts(List<dynamic> products, String category){
    List<dynamic> filtered = [];
    for (Producto product in products) {
      if (product.category == category) filtered.add(product);
    }
    return filtered;
  }

  bool hasComments(Producto toCheck){
    return (toCheck.category == "Comida Rápida" || toCheck.category == "Desayunos" || toCheck.category == "Parrilla" ||  toCheck.category == "Menús del día");
  }

  showLoader(BuildContext context){
    AlertDialog alert = AlertDialog(
      content: Container(height: 150, child: CircularProgressIndicator())
    );
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context){
        return alert;
      }
    );
  }
}
