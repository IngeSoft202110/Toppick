import 'package:Toppick_App/Products/Models/producto.dart';

class Desayuno extends Producto{
  DateTime horaInicioDisponibilidad, horaFinDisponibilidad;
  String tipo;
  String comentarios = "";
  Desayuno(this.horaInicioDisponibilidad, this.horaFinDisponibilidad, this.tipo, int id,
  String name, int price, int preparationTime, double score, String urlImage, String category):
  super(id, name, price, preparationTime, score, urlImage, category);

  void addComments(String comments){
    this.comentarios = comments;
  }
}