abstract class Producto {
  int id;
  String name;
  int price;
  int preparationTime;
  double score;
  String ulrImage;
  String category;
  Producto(this.id, this.name, this.price, this.preparationTime, this.score, this.ulrImage, this.category);

  @override
  // ignore: hash_and_equals
  bool operator ==(object){
    return (object is Producto) && object.id == this.id;
  }
}
