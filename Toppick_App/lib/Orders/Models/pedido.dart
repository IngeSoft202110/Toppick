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
    return this.carrito.containsKey(toCheck);
  }

  bool productInShopOrder(Tienda toCheck, Producto toVerify){
    return this.carrito[toCheck]!.containsKey(toVerify);
  }

  void addQuantityToExistingProduct(Tienda store, Producto toAdd, int quantity){
    int newValue = this.carrito[store]![toAdd]! + quantity;
    this.carrito[store]![toAdd] = newValue;
  }

  void addProductToSelectedStore(Tienda store, Producto toAdd, int quantity){
    this.carrito[store]!.addAll({toAdd:quantity});
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