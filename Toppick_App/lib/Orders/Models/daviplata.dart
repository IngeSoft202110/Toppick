import 'package:Toppick_App/Orders/Models/metodopago.dart';

class DaviPlata extends MetodoPago{
  int id;
  int availableAmount;
  int numeroCelular;
  DaviPlata(this.id, this.availableAmount, this.numeroCelular) : super(id, availableAmount);
}