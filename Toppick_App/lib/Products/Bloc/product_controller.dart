import 'package:Toppick_App/Products/Models/combo.dart';

import '../Models/producto.dart';
import '../Repositories/product_queries.dart';

class ProductController {
  ProductQueries productqueries = new ProductQueries();
  List<String> categories = ['Horneados', 'Empaquetados', 'Bebidas', 'A la carta', 'Combos', 'Otros',];
  List<String> descriptions = [
    'Productos horneados.',
    'Productos Empaquetados.',
    'Bebidas refrescantes.',
    'Platos personalizables.',
    'Combo de productos.',
    'Productos que no cumplen con las caracteristicas de los demás.',
  ];
  List<String> logoPahts = [
    'assets/icons/horneados.png',
    'assets/icons/empaquetados.png',
    'assets/icons/bebidas.png',
    'assets/icons/alacarta.png',
    'assets/icons/combos.png',
    'assets/icons/otros.png',
  ];

  ProductController() {
    this.productqueries = new ProductQueries();
  }

  List<dynamic> getAllAvailableProducts() {
    return this.productqueries.getAllAvailableProducts();
  }

  List<Combo> getAllAvailableComboProducts() {
    return this.productqueries.getAllAvailableComboProducts();
  }

  List<dynamic> getProductCatalogueById(int storeId) {
    return this.productqueries.getProductCatalogueById(storeId);
  }

  dynamic getProductById(int id) {
    return this.productqueries.getProductById(id);
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
      //if (product.runtimeType.toString() == category) filtered.add(product); 
    }
    return filtered;
  }
}
