import 'package:Toppick_App/GeneralUserInterfaces/generic_button.dart';
import 'package:Toppick_App/Orders/Bloc/order_controller.dart';
import 'package:Toppick_App/Orders/Models/pedido.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

showCorrectPayment(BuildContext context){
  Widget okButton = TextButton(
    child: Text("OK"),
    onPressed: () { Navigator.of(context).pop(); Navigator.of(context).pop();Navigator.of(context).pop();}
  );
  AlertDialog alert = AlertDialog(
    title: Text("Pedido realizado", style: TextStyle(color: Color(0xFF0CC665)),),
    content: Text("Pedido realizado, muchas gracias por elegirnos."),
    actions: [
      okButton,
    ],
  );
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}

showInCorrectPayment(BuildContext context){
  Widget okButton = TextButton(
    child: Text("OK"),
    onPressed: () { Navigator.of(context).pop(); Navigator.of(context).pop();Navigator.of(context).pop();}
  );
  AlertDialog alert = AlertDialog(
    title: Text("Error realizando el pedido", style: TextStyle(color: Color(0xFFD76060)),),
    content: Text("Ha ocurrido un error realizando el pedido."),
    actions: [
      okButton,
    ],
  );
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}

showNotEnoughMoney(BuildContext context){
  Widget okButton = TextButton(
    child: Text("OK"),
    onPressed: () { Navigator.of(context).pop();Navigator.of(context).pop();}
  );
  AlertDialog alert = AlertDialog(
    title: Text("No hay dinero suficiente", style: TextStyle(color: Color(0xFFD76060)),),
    content: Text("Su método de pago no tiene dinero suficiente para realizar el pedio, por favor seleccione otro."),
    actions: [
      okButton,
    ],
  );
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}

showBackWarning(BuildContext context){
  Widget yesButton = TextButton(
    child: Text("Si"),
    onPressed: () { Navigator.of(context).pop(); Navigator.of(context).pop();},
  );
  Widget noButton = TextButton(
    child: Text("No"),
    onPressed: () { Navigator.of(context).pop();},
  );
  AlertDialog alert = AlertDialog(
    title: Text("Cancelar pago", style: TextStyle(color: Color(0xFFD76060)),),
    content: Text("¿Está seguro de querer volver al pedido?"),
    actions: [
      yesButton,
      noButton,
    ],
  );
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}
class PaymentCard extends StatelessWidget {
  PaymentCard(this.imagePath, this.totalValue, this.paymentMethod, this.actual, this.timeSend, this.prefs);
  final String imagePath;
  final int totalValue;
  final dynamic paymentMethod;
  final Pedido actual;
  final DateTime timeSend;
  final OrderController controller = OrderController();
  final prefs;

  Widget textForPrice(String title, int value){
    var formatter = NumberFormat('#,###,000');
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(top: 10.0, left: 15.0,bottom: 5.0), 
          child: Text(title, style: TextStyle(color: Color(0xFFEC2B6A), fontWeight: FontWeight.bold, fontSize: 35),)
        ),
        Container(
          margin: EdgeInsets.only(top: 5.0, left: 15.0,bottom: 10.0), 
          child: Text("\$ ${formatter.format(value)}", style: TextStyle(fontSize: 25),)
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
    this.actual.fechaReclamo = this.timeSend;
    void finish(BuildContext context){
      if(this.paymentMethod!.availableAmount > this.totalValue){
        this.actual.fechaCreacion = DateTime.now();
        this.actual.costoTotal = this.totalValue;
        this.controller.sendOrder(this.actual, this.prefs).then(
          (value){
            if(value){
              this.actual.carrito.clear();
              this.actual.costoTotal = 0;
              this.actual.fechaCreacion = DateTime.now();
              this.actual.fechaReclamo = DateTime.now();
              showCorrectPayment(context);
            }else{
              showInCorrectPayment(context);
            }
          }
        );
      }else{
        showNotEnoughMoney(context);
      }
    }
    var transitionFinishOrder = () => finish(context);
    var transitionBack = () => showBackWarning(context);
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