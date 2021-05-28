import 'package:Toppick_App/GeneralUserInterfaces/generic_button.dart';
import 'package:Toppick_App/GeneralUserInterfaces/gradiant.dart';
import 'package:Toppick_App/Orders/Models/metodopago.dart';
import 'package:Toppick_App/Orders/UserInterfaces/add_method_radio_buttons.dart';
import 'package:Toppick_App/Orders/UserInterfaces/add_method_screen.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class AddMethodStartPage extends StatelessWidget {
  AddMethodStartPage(this.methods,);
  final List<MetodoPago> methods;
  String selected = "";

  void changeValue(String nSelected){
    this.selected = nSelected;
  }

  void showError(BuildContext context){
    Widget okButton = TextButton(
      child: Text("OK"),
      onPressed: () { Navigator.of(context).pop();},
    );
    AlertDialog alert = AlertDialog(
      title: Text("Error", style: TextStyle(color: Color(0xFFD76060)),),
      content: Text("Por favor seleccione un método de pago para poder continuar."),
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

  @override
  Widget build(BuildContext context) {
    var nextPage = (){
      if(this.selected.isEmpty){
        showError(context);
      }else{
        Navigator.push(context, MaterialPageRoute(builder: (context) => AddMethodScreen(this.selected)));
      }
    };
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Gradiant(),
          Container(
            margin: EdgeInsets.only(top: 5.0),
            height: MediaQuery.of(context).size.height,
            width: double.infinity,
            child: ListView(
              children: <Widget>[
                Image.asset("assets/img/logo.png"),
                Center(child: Text("Escoge tu método de pago", style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold, color: Colors.white),)),
                RadioButtonListMethods(this.methods, this.changeValue),
                Center(child: GenericButton("Seleccionar", Color(0xFFBB4900), 250, 40, 10, 10, 10, 10, 25, 15, nextPage)),
                Center(child: GenericButton("Volver", Color(0xFF2196F3), 250, 40, 10, 10, 10, 10, 25, 15, ()=>{Navigator.of(context).pop()})),
              ],
            ),
          )
        ],
      ),
    );
  }
}