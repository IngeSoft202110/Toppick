import 'package:Toppick_App/Products/Models/producto.dart';

class Bebida extends Producto{
  int contenidoML;
  String tipo;
  Bebida(this.contenidoML, this.tipo, int id, String name, int price, int preparationTime, double score, String urlImage, String category)
  :super(id, name, price, preparationTime, score, urlImage, category);
}