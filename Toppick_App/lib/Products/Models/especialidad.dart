import 'package:Toppick_App/Products/Models/acompanamiento.dart';
import 'package:Toppick_App/Products/Models/producto.dart';

class Especialidad extends Producto{
  DateTime horaInicioDisponibilidad, horaFinDisponibilidad;
  String description;
  List<Acompanamiento> acompanamientos;
  Map<Acompanamiento, bool> selecciones = new Map<Acompanamiento, bool>();
  Especialidad(this.horaInicioDisponibilidad, this.horaFinDisponibilidad, this.description, this.acompanamientos,
    int id, String name, int price, int preparationTime, double score, String urlImage, String category):
    super(id, name, price, preparationTime, score, urlImage, category);
}