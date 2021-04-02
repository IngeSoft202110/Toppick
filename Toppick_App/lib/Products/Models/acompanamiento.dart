class Acompanamiento{
  int id;
  String nombre;
  bool obligatorio;
  Acompanamiento(this.id, this.nombre, this.obligatorio);

  @override
  // ignore: hash_and_equals
  bool operator ==(object){
    return (object is Acompanamiento) && object.id == this.id;
  }
}