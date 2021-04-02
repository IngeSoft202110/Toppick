import 'package:Toppick_App/Products/Models/producto.dart';

class Fruteria extends Producto{
  String tipo, descripcion;
  Fruteria(this.tipo, this.descripcion, int id, String name, int price, int preparationTime, double score, String urlImage, String category):
    super(id, name, price, preparationTime, score, urlImage, category);
}