import 'package:Toppick_App/Products/Models/producto.dart';

class Empaquetado extends Producto{
  int contenidoGr;
  String tipo;
  Empaquetado(this.contenidoGr, this.tipo, int id, String name, int price, int preparationTime, double score, String urlImage, String category)
    :super(id, name, price, preparationTime, score, urlImage, category);
}