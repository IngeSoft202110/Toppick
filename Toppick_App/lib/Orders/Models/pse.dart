import 'package:Toppick_App/Orders/Models/metodopago.dart';

class PSE extends MetodoPago{
  int id;
  int availableAmount;
  int numeroCuenta;
  PSE(this.id, this.availableAmount, this.numeroCuenta) : super(id, availableAmount);
}