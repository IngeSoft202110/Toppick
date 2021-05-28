import 'package:Toppick_App/GeneralUserInterfaces/generic_button.dart';
import 'package:Toppick_App/GeneralUserInterfaces/gradiant.dart';
import 'package:Toppick_App/GeneralUserInterfaces/header.dart';
import 'package:Toppick_App/Orders/Models/daviplata.dart';
import 'package:Toppick_App/Orders/Models/nequi.dart';
import 'package:Toppick_App/Orders/Models/pedido.dart';
import 'package:Toppick_App/Orders/UserInterfaces/add_method_start_page.dart';
import 'package:Toppick_App/Orders/UserInterfaces/payment_method_card.dart';
import 'package:Toppick_App/Users/Bloc/user_controller.dart';
import 'package:Toppick_App/Users/Models/cliente.dart';
import 'package:flutter/material.dart';


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
      Navigator.push(context, MaterialPageRoute(builder: (context) => AddMethodStartPage(this.clienteActual.metodos)));
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
                                        child: Icon(Icons.person, size: 100,),
                                      ),
                                      Flexible(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Text(this.clienteActual.nombreCompleto, style: TextStyle(color: Color(0xFFD76060), fontSize: 30, fontWeight: FontWeight.bold),),
                                            Text(this.clienteActual.correo, style: TextStyle(color: Color(0xFFB7B7B7), fontSize: 12)),
                                            Text("${this.clienteActual.celular}", style: TextStyle(color: Color(0xFFB7B7B7), fontSize: 12)),
                                          ],
                                        ),
                                      ),
                                      IconButton(icon: Icon(Icons.edit), onPressed: ()=>{})
                                    ],
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
                                    child: Text("Tus métodos de pago", style: TextStyle(color: Color(0xFFD76060), fontSize: 25, fontWeight: FontWeight.bold),),
                                  ),
                                  if(this.clienteActual.metodos.length!=0)
                                  SizedBox(
                                    height: 230,
                                    child: ListView.builder(
                                      itemCount: this.clienteActual.metodos.length,
                                      scrollDirection: Axis.horizontal,
                                      itemBuilder: (BuildContext context, int index) => PaymentMethodCard(this.clienteActual.metodos[index])
                                    )
                                  ),
                                  if(this.clienteActual.metodos.length < 3) Center(child: GenericButton("Agregar método de pago", Color(0xFF0CC665), 200, 30, 15, 5, 0, 5, 15, 15, f1)),
                                  SizedBox(
                                    height: MediaQuery.of(context).size.height*0.25,
                                  )
                                ],
                              );
                            }else{
                              return Center(
                                child: Text(
                                  "No se encontró el contenido del combo", 
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