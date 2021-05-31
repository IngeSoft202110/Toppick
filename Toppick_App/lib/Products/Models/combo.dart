import 'producto.dart';

class Combo extends Producto {
  List<dynamic> products = [];
  Combo(int id, String name, String description, int price, int preparationTime, double score, String urlImage, String category, String type)
      : super(id, name, description, price, preparationTime, score, urlImage, category, type);
  
  factory Combo.fromJson(Map<String, dynamic> json){
    return Combo(
      json['idProducto'],
      json['nombreProducto'],
      json['descripcion'],
      json['precio'],
      json['tiempoPreparacion'],
      (json['calificacion']==null)?0:json['calificacion'],
      (json['urlImagen']==null)?"assets/img/pescadito.jpg":json['urlImagen'],
      json['categoria'],
      json['tipo']);
  }
}
