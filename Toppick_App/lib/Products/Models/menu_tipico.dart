import 'package:Toppick_App/Products/Models/producto.dart';

class MenuTipico extends Producto{
  String descripcion;
  DateTime horaInicioDisponibilidad;
  DateTime horaFinDisponibilidad;
  MenuTipico(this.descripcion, this.horaInicioDisponibilidad, this.horaFinDisponibilidad, int id, String name, int price, int preparationTime, double score, String urlImage, String category):
    super(id, name, price, preparationTime, score, urlImage, category);
}