class Producto {
  int id;
  String name;
  String description;
  int price;
  int preparationTime;
  double score;
  String ulrImage;
  String category;
  String type;
  String comments = "";
  Producto(this.id, this.name, this.description,this.price, this.preparationTime, this.score, this.ulrImage, this.category, this.type);

  @override
  bool operator ==(object){
    return (object is Producto) && object.id == this.id;
  }

  @override
  int get hashCode => this.id;

  void addComments(String comment){
    this.comments = comment;
  }

  factory Producto.fromJson(Map<String, dynamic> json){
    return Producto(
      json['idProducto'],
      json['nombreProducto'],
      json['descripcion'],
      json['precio'],
      json['tiempoPreparacion'],
      (json['calificacion']==null)?0:json['calificacion'],
      (json['urlImagen']==null)?"assets/img/pescadito.jpg":json['urlImagen'],
      json['categoria'],
      json['tipo']
    );
  }
}
