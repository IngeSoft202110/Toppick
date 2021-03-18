import 'package:Toppick_App/Products/Models/producto.dart';
import 'package:Toppick_App/Shops/Models/tienda.dart';

class Pedido{
  int idPedido;
  DateTime fecha;
  int costoTotal;
  int tiempoReclamo;
  String estadoPedido;
  String razonRechazo;
  Map<Tienda, List<Producto>> carrito = Map<Tienda, List<Producto>>();
  Pedido(this.idPedido, this.fecha, this.costoTotal, this.tiempoReclamo, this.estadoPedido, {this.razonRechazo = ""});
}