import 'producto.dart';

class Combo extends Producto {
  DateTime inicio, finalizacion;
  List<Producto> productos = [];
  Combo(this.inicio, this.finalizacion, this.productos, id, name, price,
      description, preparationTime, score, category)
      : super(id, name, price, description,
            preparationTime, score, category);
}
