import 'package:Toppick_App/GeneralUserInterfaces/generic_button.dart';
import 'package:Toppick_App/Orders/Models/metodopago.dart';
import 'package:Toppick_App/Orders/Models/pedido.dart';
import 'package:Toppick_App/Orders/UserInterfaces/ordercard.dart';
import 'package:Toppick_App/main.dart';
import 'package:flutter/material.dart';

class PaymentCard extends StatelessWidget {
  PaymentCard(this.imagePath, this.totalValue, this.paymentMethod, this.actual);
  final String imagePath;
  final int totalValue;
  final MetodoPago? paymentMethod;
  final Pedido actual;

  Widget textForPrice(String title, int value){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(top: 10.0, left: 15.0,bottom: 5.0), 
          child: Text(title, style: TextStyle(color: Color(0xFFEC2B6A), fontWeight: FontWeight.bold, fontSize: 35),)
        ),
        Container(
          margin: EdgeInsets.only(top: 5.0, left: 15.0,bottom: 10.0), 
          child: Text("\$ $value", style: TextStyle(fontSize: 25),)
        )
      ],
    );
  }

  Widget buttons(var transitionFinishOrder, var transitionBack){
    return Column(
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(top: 105.0),
          child: GenericButton("Realizar Compra", Color(0xFF0CC665), 250.0, 55.0, 10.0,
            10.0, 10.0, 10.0, 30.0, 20.0, transitionFinishOrder),
        ),
        GenericButton("Cancelar Compra", Color(0xFFFB2900), 250.0, 55.0, 10.0,
            10.0, 10.0, 10.0, 30.0, 20.0, transitionBack),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget finish(BuildContext context){
      //Enviar el pedido al servidor, también mandarlo con el DateTime.now() en caso de que incluya horas
      this.actual.carrito.clear();
      this.actual.costoTotal = 0;
      this.actual.fecha = DateTime.now();
      this.actual.tiempoReclamo = 0;
      return MyApp();
    }
    var transitionFinishOrder = () => Navigator.push(context, MaterialPageRoute(builder: finish));
    var transitionBack = () => Navigator.push(context, MaterialPageRoute(builder: (context)=>OrderCard(this.actual)));
    return Scaffold(
      body: Container(
        margin: EdgeInsets.only(top: 5.0),
        height: MediaQuery.of(context).size.height,
        width: double.infinity,
        child: ListView(
          children: <Widget>[    
            Image.asset(this.imagePath, height: 150,),
            textForPrice("Disponible", this.paymentMethod!.availableAmount),
            textForPrice("Valor compra", this.totalValue),
            buttons(transitionFinishOrder, transitionBack),
          ],
        ),
      ),
    );
  }
}