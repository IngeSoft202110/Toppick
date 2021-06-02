class Resena{
  int calificacion;
  String descripcion;
  String nombreAutor;
  double calificacionPadre = 0;
  Resena(this.calificacion, this.descripcion, this.nombreAutor, {this.calificacionPadre=0});

  factory Resena.fromJson(Map<String, dynamic> json, double calif){
    return Resena(json["calificacion"], json["descripcion"], json["nombreCompleto"], calificacionPadre: calif);
  }
}