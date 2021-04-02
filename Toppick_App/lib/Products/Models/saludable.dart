import 'package:Toppick_App/Products/Models/producto.dart';

class Saludable extends Producto{
  String descripcion;
  Saludable(this.descripcion, int id, String name, int price, int preparationTime, double score, String urlImage, String category):
    super(id, name, price, preparationTime, score, urlImage, category);
}