import 'package:Toppick_App/Products/Models/producto.dart';

class ComidaRapida extends Producto{
  String tipo, description;
  String comentarios = "";
  ComidaRapida(this.tipo, this.description, int id, String name, int price, int preparationTime, double score, String urlImage, String category):
    super(id, name, price, preparationTime, score, urlImage, category);

  void addComments(String comments){
    this.comentarios = comments;
  }
}