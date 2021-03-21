import 'package:Toppick_App/Products/Models/producto.dart';

class Otros extends Producto{
  String tipo;
  Otros(this.tipo, id, String name, int price, String description, int preparationTime, double score, String category)
    :super(id, name, price, description, preparationTime, score, category);
}