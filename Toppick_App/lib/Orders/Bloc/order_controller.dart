import '../Models/pedido.dart';
import '../Repositories/orders_queries.dart';

class OrderController {
  OrdersQueries orderqueries = new OrdersQueries();
  OrderController() {
    this.orderqueries = new OrdersQueries();
  }

  List<Pedido> getFavoriteOrders() {
    return this.orderqueries.getFavoriteOrders();
  }

  List<Pedido> getOrderHistory() {
    return this.orderqueries.getOrderHistory();
  }

  Pedido getOrderStatusResponse() {
    return this.orderqueries.getOrderStatusResponse();
  }

  bool postOrder(Pedido order) {
    return this.orderqueries.postOrder(order);
  }
}
