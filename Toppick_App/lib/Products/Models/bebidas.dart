import 'package:Toppick_App/Products/Models/producto.dart';

class Bebidas extends Producto{
  String contenidoMl;
  String tipo;
  Bebidas(this.contenidoMl, this.tipo, id, String name, int price, String description, int preparationTime, double score, String category)
  :super(id, name, price, description, preparationTime, score, category);
}