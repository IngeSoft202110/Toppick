import 'package:Toppick_App/Products/Models/acompanamiento.dart';
import 'package:Toppick_App/Products/Models/combo.dart';

import '../Models/producto.dart';
import '../Repositories/product_queries.dart';

class ProductController {
  ProductQueries productqueries = new ProductQueries();
  List<String> categories = [
    'Especialidades',
    'Desayunos',
    'Comida Rápida',
    'Parrilla',
    'Pastas',
    'Frutería',
    'Menús Típicos',
    'Menús del día',
    'Bebidas',
    'A la carta',
    'Saludables',
    'Empaquetados',
    'Combos',
    'Otros',
  ];
  List<String> descriptions = [
    'Productos especializados de la universidad.', //Especialidades
    'Desayunos de la universidad.', //Desayunos
    'Comidas rápidas de la universidad.', //Comida rápida
    'Productos a la parrilla.', //Parrilla
    'Pastas de la universidad.', //Pasta
    'Productos de las fruterías de la universidad.', //Frutería
    'Almuerzos típicos que ofrece la universidad.', //Menús típicos
    'Almuerzos del día que ofrece la universidad', //Menús del día
    'Bebidas naturales, frías y calientes.', //Bebidas
    'Productos de la carta de la universidad.', //A la carta
    "Productos saludables de la universidad.", //Saludables
    'Productos Empaquetados.', //Empaquetados
    'Combo de productos.', //Combos
    'Productos que no cumplen con las caracteristicas de los demás.',//Otros
  ];
  List<String> logoPahts = [
    'assets/icons/especialidad.png',
    'assets/icons/desayunos.png',
    'assets/icons/comidarapida.png',
    'assets/icons/parrilla.png',
    'assets/icons/pasta.png',
    'assets/icons/fruteria.png',
    'assets/icons/menus.png',
    'assets/icons/menus.png',
    'assets/icons/bebidas.png',
    'assets/icons/alacarta.png',
    'assets/icons/saludables.png',
    'assets/icons/empaquetados.png',
    'assets/icons/combos.png',
    'assets/icons/otros.png',
  ];

  ProductController() {
    this.productqueries = new ProductQueries();
  }

  Future<List<dynamic>> getAllAvailableProducts() {
    return this.productqueries.getAllAvailableProducts();
  }

  List<Combo> getAllAvailableComboProducts() {
    return this.productqueries.getAllAvailableComboProducts();
  }

  Future<List<dynamic>> getProductCatalogueById(int storeId) {
    return this.productqueries.getProductCatalogueById(storeId);
  }

  Future<List<dynamic>> getComboProducts(int comboId){
    return this.productqueries.getComboProducts(comboId);
  }

  Future<List<Acompanamiento>> getAditionsOfProduct(int idProduct){
    return this.productqueries.getAditionsOfProduct(idProduct);
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
}
