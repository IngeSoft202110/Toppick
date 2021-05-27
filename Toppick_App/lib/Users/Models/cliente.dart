import 'package:Toppick_App/Orders/Models/metodopago.dart';

class Cliente{
  int id;
  String nombres;
  String apellidos;
  int documento;
  String tipoDocumento;
  String correo;
  String password;
  int celular;
  List<MetodoPago> metodos = [];
  Cliente(this.id, this.nombres, this.apellidos, this.documento, this.tipoDocumento, this.correo, this.password, this.celular);
}