import 'producto.dart';

class Combo extends Producto {
  DateTime inicio, finalizacion;
  List<dynamic> productos = [];
  Combo(this.inicio, this.finalizacion, this.productos, id, name, price,
      description, preparationTime, score, category)
      : super(id, name, price, description,
            preparationTime, score, category);
}
