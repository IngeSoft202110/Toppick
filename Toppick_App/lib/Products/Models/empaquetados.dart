import 'package:Toppick_App/Products/Models/producto.dart';

class Empaquetados extends Producto{
  String contenidoGr;
  String tipo;
  Empaquetados(this.contenidoGr, this.tipo, id, String name, int price, String description, int preparationTime, double score, String category)
    :super(id, name, price, description, preparationTime, score, category);
}