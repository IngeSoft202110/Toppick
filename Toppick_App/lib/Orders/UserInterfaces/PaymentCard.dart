import 'package:Toppick_App/GeneralUserInterfaces/generic_button.dart';
import 'package:Toppick_App/Orders/Models/paymentmethod.dart';
import 'package:Toppick_App/main.dart';
import 'package:flutter/material.dart';

class PaymentCard extends StatelessWidget {
  PaymentCard(this.imagePath, this.totalValue, this.paymentMethod);
  final String imagePath;
  final int totalValue;
  final MetodoPago paymentMethod;

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

  Widget buttons(var transition){
    return Column(
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(top: 105.0),
          child: GenericButton("Realizar Compra", Color(0xFF0CC665), 250.0, 55.0, 10.0,
            10.0, 10.0, 10.0, 30.0, 20.0, transition),
        ),
        GenericButton("Cancelar Compra", Color(0xFFFB2900), 250.0, 55.0, 10.0,
            10.0, 10.0, 10.0, 30.0, 20.0, transition),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    var transition = () => Navigator.push(context, MaterialPageRoute(builder: (context) => MyApp()));
    return Scaffold(
      body: Container(
        margin: EdgeInsets.only(top: 5.0),
        height: MediaQuery.of(context).size.height,
        width: double.infinity,
        child: ListView(
          children: <Widget>[    
            Image.asset(this.imagePath, height: 150,),
            textForPrice("Disponible", this.paymentMethod.availableAmount),
            textForPrice("Valor compra", this.totalValue),
            buttons(transition),
          ],
        ),
      ),
    );
  }
}