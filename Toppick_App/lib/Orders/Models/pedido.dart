import 'package:Toppick_App/Products/Models/producto.dart';
import 'package:Toppick_App/Shops/Models/tienda.dart';

class Pedido{
  int idPedido;
  DateTime fechaCreacion;
  int costoTotal;
  DateTime fechaReclamo;
  String estadoPedido;
  String razonRechazo;
  Map<Tienda?, Map<Producto, int>> carrito = Map<Tienda?, Map<Producto, int>>();
  Pedido(this.idPedido, this.fechaCreacion, this.costoTotal, this.fechaReclamo, this.estadoPedido, {this.razonRechazo = "NULL"});


  bool storeIsInCurrentOrder(Tienda toCheck){
    bool result = false;
    this.carrito.forEach((key, value) {
      if(key!.id == toCheck.id){
        result = true;
      }
    });
    return result;
  }

  bool productInShopOrder(Tienda toCheck, Producto toVerify){
    bool result = false;
    this.carrito.forEach((key, value) {
      if(key!.id == toCheck.id){
        value.forEach((key, value) {
          if(key.id == toVerify.id){
            result = true;
          }
        });
      }
    });
    return result;
  }

  void addQuantityToExistingProduct(Tienda store, Producto toAdd, int quantity){
    this.carrito.forEach((key, value) {
      if(key!.id == store.id){
        value.forEach((key, value) {
          if(key.id == toAdd.id){
            value+=quantity;
          }
        });
      }
    });
  }

  void addProductToSelectedStore(Tienda store, Producto toAdd, int quantity){
    this.carrito.forEach((key, value) {
      if(key!.id == store.id){
        value.addAll({toAdd: quantity});
      }
    });
  }

  void addStoreWithProducts(Tienda store, Producto toAdd, int quantity){
    this.carrito.addAll({store:{toAdd:quantity}});
  }

  factory Pedido.fromJsonList(Map<String, dynamic> json){
    return Pedido(
      json['idPedido'],
      DateTime.now(),
      json['costoTotal'],
      DateTime.parse(json['fechaReclamo']),
      json['estadoPedido']);
  }
}