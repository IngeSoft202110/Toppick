class Resena{
  int calificacion;
  String descripcion;
  String nombreAutor;
  Resena(this.calificacion, this.descripcion, this.nombreAutor);

  factory Resena.fromJson(Map<String, dynamic> json){
    return Resena(json["calificacion"], json["descripcion"], json["nombreCompleto"]);
  }
}