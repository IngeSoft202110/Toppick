import 'package:Toppick_App/GeneralUserInterfaces/generic_button.dart';
import 'package:Toppick_App/GeneralUserInterfaces/gradiant.dart';
import 'package:Toppick_App/GeneralUserInterfaces/header.dart';
import 'package:Toppick_App/Orders/Models/pedido.dart';
import 'package:Toppick_App/Orders/UserInterfaces/add_method_start_page.dart';
import 'package:Toppick_App/Orders/UserInterfaces/payment_method_card.dart';
import 'package:Toppick_App/Users/Bloc/user_controller.dart';
import 'package:Toppick_App/Users/Models/cliente.dart';
import 'package:Toppick_App/Users/UserInterfaces/edit_user_info_screen.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';


// ignore: must_be_immutable
class Profile extends StatelessWidget {
  Profile(this.actual, this.prefs);
  final Pedido actual;
  final prefs;
  final UserController controller = UserController();
  late Cliente clienteActual =  Cliente(0, "", 0, "", "", "", 0);

  @override
  Widget build(BuildContext context) {
    var f1 = (){
      Navigator.pop(context);
      Navigator.push(context, MaterialPageRoute(builder: (context) => AddMethodStartPage(this.clienteActual.metodos, this.prefs, this.actual)));
    };
    var f2 = (){
      Navigator.pop(context);
      Navigator.push(context, MaterialPageRoute(builder: (context) => EditUserInfoScreen(this.clienteActual, this.prefs, this.actual)));
    };
    var formatter = NumberFormat('#,###,000');
    int money = 0;
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
                  child: Header(this.actual, this.prefs),
                ),
                Container(
                  decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(40)), color: Color(0xFFFFFEEE),),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: FutureBuilder(
                      future: this.controller.getUserInfo(this.prefs.getString('cookie'), this.prefs.getString('correo')),
                      builder: (BuildContext context, AsyncSnapshot<Cliente> snapshot) {
                        switch(snapshot.connectionState){
                          case ConnectionState.none:
                            break;
                          case ConnectionState.waiting:
                            break;
                          case ConnectionState.active:
                            break;
                          case ConnectionState.done:
                            if(snapshot.hasData){
                              this.clienteActual = snapshot.data!;
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Container(
                                        padding: EdgeInsets.only(left:5.0),
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          shape: BoxShape.circle,
                                        ),
                                        child: Icon(Icons.person, size: 115,),
                                      ),
                                      Flexible(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Text(this.clienteActual.nombreCompleto, style: TextStyle(color: Color(0xFFD76060), fontSize: 30, fontWeight: FontWeight.bold),),
                                            Text(this.clienteActual.correo, style: TextStyle(color: Color(0xFFB7B7B7), fontSize: 15)),
                                            Text("${this.clienteActual.celular}", style: TextStyle(color: Color(0xFFB7B7B7), fontSize: 15)),
                                          ],
                                        ),
                                      ),
                                      IconButton(icon: Icon(Icons.edit), onPressed: f2)
                                    ],
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
                                    child: Text("Tus métodos de pago", style: TextStyle(color: Color(0xFFD76060), fontSize: 25, fontWeight: FontWeight.bold),),
                                  ),
                                  FutureBuilder(
                                    future: this.controller.getPaymentMethods(this.prefs.getString('cookie')),
                                    builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot){
                                      switch(snapshot.connectionState){
                                        case ConnectionState.none:
                                          break;
                                        case ConnectionState.waiting:
                                          break;
                                        case ConnectionState.active:
                                          break;
                                        case ConnectionState.done:
                                          if(snapshot.hasData){
                                            this.clienteActual.metodos = snapshot.data!;
                                            money = this.clienteActual.metodos.first.availableAmount;
                                            return Column(
                                              children: <Widget>[
                                                Text(
                                                  "Saldo total \$${formatter.format(money)}",
                                                  style: TextStyle(color: Color(0xFF0CC665), fontSize: 25, fontWeight: FontWeight.bold),
                                                ),
                                                SizedBox(
                                                  height: 200,
                                                  child: ListView.builder(
                                                    itemCount: this.clienteActual.metodos.length,
                                                    scrollDirection: Axis.horizontal,
                                                    itemBuilder: (BuildContext context, int index) => PaymentMethodCard(this.clienteActual.metodos[index], this.prefs, this.actual)
                                                  )
                                                ),
                                                if(this.clienteActual.metodos.length < 3)
                                                Center(child: GenericButton("Agregar método de pago", Color(0xFF0CC665), 200, 30, 15, 5, 0, 5, 15, 15, f1)),
                                                SizedBox(
                                                  height: MediaQuery.of(context).size.height*0.25,
                                                )
                                              ],
                                            );
                                          }else{
                                            return Column(
                                              children: <Widget>[
                                                Text(
                                                  "Saldo total \$${0}",
                                                  style: TextStyle(color: Color(0xFF0CC665), fontSize: 25, fontWeight: FontWeight.bold),
                                                ),
                                                Center(child: GenericButton("Agregar método de pago", Color(0xFF0CC665), 200, 30, 15, 5, 0, 5, 15, 15, f1)),
                                                SizedBox(
                                                  height: MediaQuery.of(context).size.height*0.25,
                                                )
                                              ],
                                            );
                                          }
                                      }
                                      return Center(
                                        child: Container(
                                          padding: const EdgeInsets.all(10),
                                          height: 50,
                                          child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Colors.red),)
                                        ),
                                      );
                                    }
                                  ),
                                ],
                              );
                            }else{
                              return Center(
                                child: Text(
                                  "No se encontró la información de tu perfil", 
                                  style: TextStyle(color: Color(0xFFFF441F), fontWeight: FontWeight.bold),
                                )
                              );
                            }
                        }
                        return Center(
                          child: Container(
                            padding: const EdgeInsets.all(10),
                            height: 50,
                            child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Colors.red),)
                          ),
                        );
                      }
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}