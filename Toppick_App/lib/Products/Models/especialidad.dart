import 'package:Toppick_App/Products/Models/acompanamiento.dart';
import 'package:Toppick_App/Products/Models/producto.dart';

class Especialidad extends Producto{
  DateTime horaInicioDisponibilidad  = DateTime.now();
  DateTime horaFinDisponibilidad  = DateTime.now();
  List<Acompanamiento> acompanamientos = [];
  Map<Acompanamiento, bool> selecciones = new Map<Acompanamiento, bool>();
  Especialidad(int id, String name, String description, int price, int preparationTime, double score, String urlImage, String category, String type):
    super(id, name, description, price, preparationTime, score, urlImage, category, type);

  factory Especialidad.fromJson(Map<String, dynamic> json){
    return Especialidad(
      json['idProducto'],
      json['nombreProducto'],
      json['descripcion'],
      json['precio'],
      json['tiempoPreparacion'],
      (json['calificacion']==null)?0:json['calificacion'].toDouble(),
      (json['urlImagen']==null)?"assets/img/pescadito.jpg":json['urlImagen'],
      json['categoria'],
      json['tipo']);
  }
}