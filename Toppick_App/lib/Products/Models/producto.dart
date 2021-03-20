class Producto {
  int id;
  String name;
  int price;
  String description;
  int preparationTime;
  double score;
  String category;
  Producto(this.id, this.name, this.price,
      this.description, this.preparationTime, this.score, this.category);

  @override
  // ignore: hash_and_equals
  bool operator ==(object){
    return (object is Producto) && object.id == this.id;
  }
}
