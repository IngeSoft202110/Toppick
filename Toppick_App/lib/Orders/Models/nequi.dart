import 'package:Toppick_App/Orders/Models/metodopago.dart';

class Nequi extends MetodoPago{
  int id;
  int availableAmount;
  int numeroCelular;
  Nequi(this.id, this.availableAmount, this.numeroCelular) : super(id, availableAmount);
}