import 'package:Toppick_App/Products/Models/producto.dart';
import 'package:Toppick_App/Shops/Models/tienda.dart';

class Pedido{
  int idPedido;
  DateTime fecha;
  int costoTotal;
  int tiempoReclamo;
  String estadoPedido;
  String razonRechazo;
  Map<Tienda?, Map<Producto, int>> carrito = Map<Tienda?, Map<Producto, int>>();
  Pedido(this.idPedido, this.fecha, this.costoTotal, this.tiempoReclamo, this.estadoPedido, {this.razonRechazo = ""});
}