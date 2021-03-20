import '../Models/tienda.dart';
import '../Repositories/shop_queries.dart';

class ShopController {
  ShopQueries shopQueries = new ShopQueries();
  List<String> categories = ['Cafeterias', 'Cafes y Kioskos', 'Saludable', 'Restaurantes',];
  List<String> descriptions = [
    'Cafeterias de la universidad',
    'Cafes y Kioscos ubicados en la universidad, los puedes encontrar en muchos lugares',
    'Puntos de venta de comida saludable',
    'Restaurantes de la universidad',
  ];
  List<String> logoPahts = [
    'assets/icons/cafeteria.png',
    'assets/icons/cafesykioskos.png',
    'assets/icons/saludable.png',
    'assets/icons/restaurantes.png',
  ];
  ShopController() {
    this.shopQueries = new ShopQueries();
  }

  List<Tienda> getAllAvailableShops() {
    return this.shopQueries.getAllAvailableShops();
  }

  Tienda getShopById(int id) {
    return this.shopQueries.getShopById(id);
  }

  List<String> getShopCategories(){
    return this.categories;
  }

  List<String> getCategoryDescription(){
    return this.descriptions;
  }

  List<String> getCategoryImagePath(){
    return this.logoPahts;
  }

  List<Tienda> filterShops(List<Tienda> shops, String category){
    List<Tienda> filtered = [];
    for(Tienda shop in shops){
      if(shop.category == category)filtered.add(shop);
    }
    return filtered;
  }

  List<Tienda> getAvailableShopsByProduct(int productId) {
    return this.shopQueries.getAvailableShopsByProduct(productId);
  }
}
