class Tienda {
  int id;
  String name;
  String category;
  String schedule;
  String description;
  String url;
  bool status;
  String ubication;
  Tienda(this.id, this.name, this.category, this.schedule, this.description, this.url,
      this.status, this.ubication);
  @override
  // ignore: hash_and_equals
  bool operator ==(object){
    return (object is Tienda) && object.id == this.id;
  }
}
