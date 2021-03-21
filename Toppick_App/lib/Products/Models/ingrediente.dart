class Ingrediente{
  int id;
  String nombre;
  bool obligatorio;
  Ingrediente(this.id, this.nombre, this.obligatorio);

  @override
  // ignore: hash_and_equals
  bool operator ==(object){
    return (object is Ingrediente) && object.id == this.id;
  }
}