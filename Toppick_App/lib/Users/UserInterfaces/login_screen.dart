import 'package:Toppick_App/GeneralUserInterfaces/generic_button.dart';
import 'package:Toppick_App/GeneralUserInterfaces/gradiant.dart';
import 'package:Toppick_App/Orders/UserInterfaces/add_subtract_total.dart';
import 'package:Toppick_App/Products/Models/producto.dart';
import 'package:Toppick_App/Users/UserInterfaces/home_screen.dart';
import 'package:Toppick_App/Users/UserInterfaces/main_page.dart';
import 'package:Toppick_App/main.dart';
import 'package:flutter/material.dart';


class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var main = ()=>Navigator.push(context, MaterialPageRoute(builder: (context)=>HomeScreen()));
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: <Widget>[          
          Gradiant(),
          Container(
            height: MediaQuery.of(context).size.height,
            width: double.infinity,
            margin: EdgeInsets.only(top:5.0),
            child: Column(
              crossAxisAlignment:  CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget> [
                    Text("Iniciar Sesión",
                    style: TextStyle(
                      height: 6,
                      fontSize: 30,
                      color: Colors.white
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 70),
                      child: Image.asset("assets/img/logo.png",
                        height: 130
                      ),
                    ),
                  ],
                ),
                Container(
                  decoration: BoxDecoration(borderRadius: BorderRadius.only(topLeft: Radius.circular(40), topRight: Radius.circular(40)), color: Color(0xFFFFFEEE),),
                  height: 600, 
                  child: Column(
                    children: <Widget> [
                      Padding(
                        padding: const EdgeInsets.only(
                          top: 150,
                          right: 45,
                          left: 45,
                        ),
                        child: TextField(
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            labelText: "Correo",
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          top: 30,
                          right: 45,
                          left: 45,
                        ),
                        child: TextField(
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            labelText: "Contraseña",
                            
                          ), 
                          
                          obscureText: true,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          top: 50
                        ),
                        child: RichText(
                          text: TextSpan(
                            text:"¿Todavía no tienes cuenta?",
                            style: TextStyle(
                                color: Color(0xFFC4C4C4),                            
                              ), 
                          
                          children: <TextSpan>[
                            TextSpan(
                              text: " Registrate",
                              style: TextStyle(
                                color: Color(0xFF2196F3),
                              )
                            ),
                          ]
                          ),
                        ),
                      ),
                      GenericButton("Iniciar Sesión", Color(0xFFFD8901), 300, 40, 60, 5, 5, 5, 18, 20, main),
                  ]
                  ),                              
                ),
              ]
            ),
          ),
        ]
      ),
    );
  }
}