class Acompanamiento{
  int id;
  String nombre;
  String tipo;
  Acompanamiento(this.id, this.nombre, this.tipo);

  @override
  // ignore: hash_and_equals
  bool operator ==(object){
    return (object is Acompanamiento) && object.id == this.id;
  }

  factory Acompanamiento.fromJson(Map<String, dynamic> json){
    return Acompanamiento(
      json['idAcompañamiento'],
      json['nombreAcompañamiento'],
      json['tipo']
      );
  }
}