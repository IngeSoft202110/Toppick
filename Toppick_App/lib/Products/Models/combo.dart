import 'producto.dart';

class Combo extends Producto {
  String description;
  List<dynamic> products = [];
  Combo(this.products, this.description, int id, String name, int price, int preparationTime, double score, String urlImage, String category)
      : super(id, name, price, preparationTime, score, urlImage, category);
}
