import 'package:Toppick_App/GeneralUserInterfaces/generic_button.dart';
import 'package:Toppick_App/Orders/Models/pedido.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';


void showOrderComponents(BuildContext context, Pedido current){
  Widget okButton = TextButton(
    child: Text("OK", style: TextStyle(color: Color(0xFF2196F3))),
    onPressed: () { Navigator.of(context).pop();},
  );
  AlertDialog alert = AlertDialog(
    title: Text("Contenido del pedido", style: TextStyle(color: Color(0xFF2196F3)),),
    content: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: contents(current),
    ),
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


List<Widget> contents(Pedido current){
  List<Widget> result = [];
  int cont = 0;
    current.carrito.forEach((key, value) {
      value.forEach((key, value) {
        result.add(Container(width: double.infinity, child: Text("${cont+1}. ${key.name} ", overflow: TextOverflow.ellipsis)),);
        cont++;
      });
    });
  return result;
}

// ignore: must_be_immutable
class FavoriteOrderCard extends StatelessWidget {
  FavoriteOrderCard(this.number, this.current);
  final int number;
  final Pedido current;
  bool flag = false;

  List<Widget> fill(){
    List<Widget> result = [];
    int cont = 0;
    this.current.carrito.forEach((key, value) {
      value.forEach((key, value) {
        if(cont==3){
          this.flag = true;
        }if(!flag){
          result.add(Container(width: 150, child: Text("${cont+1}. ${key.name} ", overflow: TextOverflow.ellipsis)),);
        }
        cont++;
      });
    });
    return result;
  }

  @override
  Widget build(BuildContext context) {
    var formatter = NumberFormat('#,###,000');
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
            Row(
              children: <Widget>[
                Expanded(child: Container()),
                Icon(Icons.delete_forever, color: Colors.red,),
                Icon(Icons.edit)
              ],
            ),
            Center(child: Text("Pedido $number", style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),)),
            Column(
              children: fill(),
            ),
            Text("Valor: \$${formatter.format(this.current.costoTotal)}"),
            Center(child: GenericButton("Ver detalles", Color(0xFF2196F3), 130, 20, 5, 5, 5, 5, 15, 15, ()=>{showOrderComponents(context, this.current)})),
            Center(child: GenericButton("Disponibilidad", Color(0xFF0CC665), 130, 20, 0, 5, 5, 5, 15, 15, ()=>{}))
          ],
        ),
      ),
    );
  }
}