import '../Models/producto.dart';
import '../Repositories/product_queries.dart';

class ProductController {
  ProductQueries productqueries = new ProductQueries();
  ProductController() {
    this.productqueries = new ProductQueries();
  }

  List<Producto> getAllAvailableProducts() {
    return this.productqueries.getAllAvailableProducts();
  }

  List<Producto> getAllAvailableComboProducts() {
    return this.productqueries.getAllAvailableComboProducts();
  }

  List<Producto> getProductCatalogueById(int storeId) {
    return this.productqueries.getProductCatalogueById(storeId);
  }

  Producto getProductById(int id) {
    return this.productqueries.getProductById(id);
  }
}
