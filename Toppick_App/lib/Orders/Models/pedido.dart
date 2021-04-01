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
  Pedido(this.idPedido, this.fechaCreacion, this.costoTotal, this.fechaReclamo, this.estadoPedido, {this.razonRechazo = ""});
}