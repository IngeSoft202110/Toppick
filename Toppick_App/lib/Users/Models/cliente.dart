import 'package:Toppick_App/Orders/Models/metodopago.dart';

class Cliente{
  int id;
  String nombres;
  String apellidos;
  String celular;
  String correo;
  List<MetodoPago> metodos = [];
  Cliente(this.id, this.nombres, this.apellidos, this.celular, this.correo);
}