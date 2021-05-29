class Cliente{
  int id;
  String nombreCompleto = "";
  int documento;
  String tipoDocumento;
  String correo;
  String password;
  int celular;
  List<dynamic> metodos = [];
  Cliente(this.id, this.nombreCompleto, this.documento, this.tipoDocumento, this.correo, this.password, this.celular);

  factory Cliente.fromJson(Map<String, dynamic> json){
    return Cliente(json['IdCliente'], json['nombreCompleto'], json['idDocumento'], json['tipoDocumento'], "", "", json['celular']);
  }
}