import 'package:Toppick_App/GeneralUserInterfaces/generic_button.dart';
import 'package:Toppick_App/Orders/Models/pedido.dart';
import 'package:Toppick_App/Orders/UserInterfaces/edit_method_screen.dart';
import 'package:flutter/material.dart';

class PaymentMethodCard extends StatelessWidget {
  PaymentMethodCard(this.current, this.prefs, this.actual);
  final dynamic current;
  final prefs;
  final Pedido actual;

  Widget image(String typ){
    if(typ == "DaviPlata"){
      return Center(child: Image.asset("assets/img/daviplata.png", height: 75,));
    }else if(typ == "Nequi"){
      return Center(child: Image.asset("assets/img/nequi.jpg", height: 75,));
    }else{
      return Center(child: Image.asset("assets/img/pse.jpg", height: 75,));
    }
  }

  Widget information(String typ){
    if(typ == "DaviPlata" || typ == "Nequi"){
      return Text("Celular: ${this.current.numeroCelular}", overflow: TextOverflow.ellipsis);
    }else{
      return Flexible(child: Text("Cuenta: ${this.current.numeroCuenta}"));
    }
  }

  @override
  Widget build(BuildContext context) {
    var editPage = (){
      Navigator.pop(context);
      Navigator.push(context, MaterialPageRoute(builder: (context) => EditMethodScreen(this.current, this.prefs, this.actual)));
    };
    return Padding(
      padding: EdgeInsets.only(left: 20.0, right: 20.0, top: 10.0, bottom: 10.0),
      child: Container(
        padding: const EdgeInsets.only(top: 5.0, bottom: 5.0, left: 10.0, right: 10.0),
        width: 180,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(15)), 
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black38, blurRadius: 5.0, offset: Offset(0.0, 5.0)
            )
          ]
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            image(this.current.runtimeType.toString()),
            Center(child: GenericButton("Editar", Color(0xFF2196F3), 130, 20, 5, 5, 5, 5, 15, 15, editPage)),
          ],
        ),
      ),
    );
  }
}