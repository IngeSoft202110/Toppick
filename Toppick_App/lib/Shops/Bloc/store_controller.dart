import '../Models/tienda.dart';
import '../Repositories/store_queries.dart';

class StoreController {
  StoreQueries storequeries = new StoreQueries();
  StoreController() {
    this.storequeries = new StoreQueries();
  }

  List<Tienda> getAllAvailableStores() {
    return this.storequeries.getAllAvailableStores();
  }

  Tienda getStoreById(int id) {
    return this.storequeries.getStoreById(id);
  }

  List<Tienda> getAvailableStoresByProduct(int productId) {
    return this.storequeries.getAvailableStoresByProduct(productId);
  }
}
