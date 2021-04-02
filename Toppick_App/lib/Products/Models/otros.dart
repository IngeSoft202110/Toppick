import 'package:Toppick_App/Products/Models/producto.dart';

class Otros extends Producto{
  String tipo;
  Otros(this.tipo, id, String name, int price, int preparationTime, double score, String urlImage, String category)
    :super(id, name, price, preparationTime, score, urlImage, category);
}