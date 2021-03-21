import 'package:Toppick_App/GeneralUserInterfaces/generic_button.dart';
import 'package:Toppick_App/GeneralUserInterfaces/gradiant.dart';
import 'package:Toppick_App/GeneralUserInterfaces/header.dart';
import 'package:Toppick_App/Orders/Models/daviplata.dart';
import 'package:Toppick_App/Orders/Models/metodopago.dart';
import 'package:Toppick_App/Orders/Models/nequi.dart';
import 'package:Toppick_App/Orders/Models/pedido.dart';
import 'package:Toppick_App/Orders/UserInterfaces/add_subtract_total.dart';
import 'package:Toppick_App/Orders/UserInterfaces/payment_card.dart';
import 'package:Toppick_App/Orders/UserInterfaces/payment_selection.dart';
import 'package:Toppick_App/Products/Models/producto.dart';
import 'package:Toppick_App/main.dart';
import 'package:flutter/material.dart';

List<MetodoPago> methods =[
  DaviPlata(1, 100000, 3004006789),
  Nequi(1, 20000, 3009990009),
];


class OrderCard extends StatefulWidget {
  OrderCard(this.actual);
  final Pedido actual;

  int calculateTotal(){
    int total = 0;
    this.actual.carrito.forEach((key, value) {
      value.forEach((key, value) {
        total+=key.price*value;
      });
    });
    return total;
  }
  @override
  _OrderCardState createState() => _OrderCardState(this.actual,calculateTotal());
}

class _OrderCardState extends State<OrderCard> {
  _OrderCardState(this.actual, this.total);
  final Pedido actual;
  int total;
  MetodoPago? selected;
  int selectedTime = 0;
  int minTime = 5;
  TextEditingController controller = TextEditingController();

  void refresh(int value, String operationType){
    setState(() {
      if(operationType == "Sum"){
        this.total+=value;
      }else if(operationType == "Substract"){
        this.total-=value;
      }
    });
  }
  void updateMethod(MetodoPago? selected) {
    this.selected = selected;
  }

  List<Widget> fill(var transitionToPay){
    var cancelTransition = () => Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => MyApp()),  ModalRoute.withName('/'));
    Widget showMethods = methods.isNotEmpty ? RadioButtonPaymentList(methods, updateMethod) :
      Center(child: GenericButton("Registrar métodos de pago", Color(0xFF0CC665), 274, 45, 15.0, 0, 0, 0, 22, 30, () => {}));
    List<Widget> result = [];
    result.add(
      Center(
        child: Padding(
          padding: const EdgeInsets.only(top: 10.0),
          child: Text("Pedido", style: TextStyle(color: Color(0xFFD76060), fontSize: 35, fontWeight: FontWeight.bold),),
        ),
      )
    );
    this.actual.carrito.forEach((key, value) {result.add(ShopxProductContent(key!.name, value, refresh));});
    result.add(
      Padding(
        padding: const EdgeInsets.only(left: 10.0, top: 30.0),
        child: Text("¿En cuántos minutos pasas?", style: TextStyle(color: Color(0xFFD76060), fontSize: 25, fontWeight: FontWeight.bold)),
      )
    );
    //Calcular valor mínimo del tiempo del pedido
    result.add(
      Padding(
        padding: const EdgeInsets.only(left:10.0, right: 40.0,),
        child: TextField(
          controller: controller,
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            hintText: "Tiempo mínimo es de $minTime minutos",
            hintStyle: TextStyle(color: Color(0xFFB7B7B7)),
          ),
        ),
      )
    );
    result.add(
      Padding(
        padding: const EdgeInsets.only(left: 10.0, right: 10.0, bottom: 15.0),
        child: Text("*El tiempo mínimo para pasar es el del producto que más se tarde en cocinar y el máximo es una hora*", style: TextStyle(color: Color(0xFFB7B7B7), fontSize: 15)),
      )
    );
    result.add(
      Padding(
        padding: const EdgeInsets.only(left: 10.0,),
        child: Text("Métodos de pago", style: TextStyle(color: Color(0xFFD76060), fontSize: 30, fontWeight: FontWeight.bold),),
      ),
    );
    result.add(showMethods);
    result.add(Center(child: GenericButton("Total: \$${this.total}", Color(0xFFBB4900), 274, 45, 15.0, 0, 0, 0, 22, 0, () => {})));
    result.add(Center(child: GenericButton("Realizar Pedido", Color(0xFF0CC665), 274, 45, 15.0, 0, 0, 0, 22, 30, () => {
      if(selected==null){
        print("No se ha seleccionado un metodo de pago")}
        else{
          transitionToPay()
        }
    })));
    result.add(Center(child: GenericButton("Cancelar predido", Color(0xFFFB2900), 274, 45, 15.0, 0, 0, 0, 22, 30, cancelTransition)));
    result.add(SizedBox(height: 30,));
    return result;
  }

  @override
  Widget build(BuildContext context) {
    Widget build(BuildContext context){
      if(this.controller.text == ""){
        this.selectedTime = this.minTime;
      }else{
        this.selectedTime = int.parse(this.controller.text);
      }
      if(this.selectedTime > 0 && this.selectedTime<= 60){
        if(this.selected.runtimeType.toString()=="DaviPlata"){
          return PaymentCard("assets/img/daviplata.png", total, selected, this.actual);
        }
        else if(this.selected.runtimeType.toString()=="Nequi"){
          return PaymentCard("assets/img/nequi.jpg", total, selected, this.actual);
        }
        else if(this.selected.runtimeType.toString()=="PSE"){
          return PaymentCard("assets/img/pse.jpg", total, selected, this.actual);
        }
      }
      return OrderCard(this.actual);
    }
    var payTransition = () => Navigator.push(context, MaterialPageRoute(builder: build));
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
                Padding(
                  padding: const EdgeInsets.only(bottom: 15.0),
                  child: Header(this.actual),
                ),
                Container(
                  decoration: BoxDecoration(borderRadius: BorderRadius.only(topLeft: Radius.circular(40), topRight: Radius.circular(40)), color: Color(0xFFFFFEEE),),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: fill(payTransition),
                  ),
                )
              ],
            ),
          )
        ],
      )
    );
  }
}

Widget element(Producto current, int currentQuantity, Function(int value, String operationType) toCallSum){
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: <Widget>[
      Flexible(
        child: Container(
          padding: new EdgeInsets.only(right: 13.0, left: 10.0),
          child: Text("${current.name}", style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 25,
                  color: Color(0xFFB7B7B7)), overflow: TextOverflow.ellipsis,),
        ),
      ),
      AddSubstract(current, currentQuantity, toCallSum),
    ],
  );
}

class ShopxProductContent extends StatelessWidget{
  ShopxProductContent(this.storeName, this.products, this.notifyParent);
  final String storeName;
  final Map<Producto, int> products;
  final Function(int value,  String operationType) notifyParent;

  List<Widget> fill(){
    List<Widget> result = [];
    result.add(
      Padding(
        padding: const EdgeInsets.only(left: 10.0, right: 10, bottom: 10.0),
        child: Text("${this.storeName}", style: TextStyle(color: Color(0xFFD76060), fontSize: 25, fontWeight: FontWeight.bold),),
      )
    );
    this.products.forEach((key, value) {
      result.add(element(key, value, notifyParent));
    });
    return result;
  }
  @override
  Widget build(BuildContext context) {
    return Column(
      children:fill(),
      crossAxisAlignment: CrossAxisAlignment.start,
    );
  }
}