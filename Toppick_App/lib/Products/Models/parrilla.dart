import 'package:Toppick_App/Products/Models/producto.dart';

class Parrilla extends Producto{
  String tipo;
  String comentarios = "";
  Parrilla(this.tipo, int id, String name, int price, int preparationTime, double score, String urlImage, String category):
    super(id, name, price, preparationTime, score, urlImage, category);

  void addComments(String comments){
    this.comentarios = comments;
  }
}