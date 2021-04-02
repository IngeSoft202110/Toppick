import 'package:Toppick_App/Products/Models/producto.dart';

class MenuDia extends Producto{
  String descripcion;
  String tipo;
  DateTime horaInicioDisponibilidad;
  DateTime horaFinDisponibilidad;
  String comentarios = "";
  MenuDia(this.descripcion, this.tipo, this.horaInicioDisponibilidad, this.horaFinDisponibilidad,
  int id, String name, int price, int preparationTime, double score, String urlImage, String category):
    super(id, name, price, preparationTime, score, urlImage, category);

  void addComments(String comments){
    this.comentarios = comments;
  }
}