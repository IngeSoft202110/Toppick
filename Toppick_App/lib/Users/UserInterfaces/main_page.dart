import 'package:Toppick_App/GeneralUserInterfaces/generic_button.dart';
import 'package:Toppick_App/GeneralUserInterfaces/gradiant.dart';
import 'package:Toppick_App/Users/UserInterfaces/login_screen.dart';
import 'package:Toppick_App/Users/UserInterfaces/register_screen.dart';
import 'package:flutter/material.dart';
class MainPage extends StatelessWidget {
  MainPage();

  @override
  Widget build(BuildContext context) {
    var login = ()=>Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginScreen()));
    var register = ()=>Navigator.push(context, MaterialPageRoute(builder: (context)=>RegisterScreen()));
    return Scaffold(
      body: Stack(
        children: <Widget> [
          Gradiant(),
          Container(
            height: MediaQuery.of(context).size.height,
            width: double.infinity,
            margin: EdgeInsets.only(top:5.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Image.asset("assets/img/logo.png"),
                Text("Tu solución para las filas",
                style: TextStyle(
                  height: 3, 
                  fontSize: 30, 
                  color: Colors.white
                  ),
                ),
                GenericButton("Iniciar sesión", Color(0xFFBB4900), 300, 40, 40, 5, 5, 5, 18, 20, login),
                GenericButton("Registrarse", Color(0xFFBB4900), 300, 40, 20, 5, 5, 5, 18, 20, register),
              ],
            ),
          ),    
        ]
      ),
    );
  }
}