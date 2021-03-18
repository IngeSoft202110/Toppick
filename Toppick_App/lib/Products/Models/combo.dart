import 'producto.dart';

class Combo extends Producto {
  DateTime inicio, finalizacion;
  List<Producto> productos = [];
  Combo(this.inicio, this.finalizacion, this.productos, id, name, price,
      nutritionalInformation, description, preparationTime, score, category)
      : super(id, name, price, nutritionalInformation, description,
            preparationTime, score, category);
}
