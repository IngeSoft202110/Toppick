import 'package:Toppick_App/Orders/Models/pedido.dart';
import 'package:Toppick_App/Users/Bloc/user_controller.dart';
import 'package:Toppick_App/GeneralUserInterfaces/generic_button.dart';
import 'package:Toppick_App/GeneralUserInterfaces/gradiant.dart';
import 'package:Toppick_App/Users/UserInterfaces/home_screen.dart';
import 'package:Toppick_App/Users/UserInterfaces/register_screen.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';


// ignore: must_be_immutable
class LoginScreen extends StatelessWidget {
  LoginScreen(this.prefs);
  final prefs;
  final UserController controller = UserController();
  late String emailValue;
  late String passwordValue;
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    void main (){
      if(formKey.currentState!.validate()){
        formKey.currentState!.save();
        this.prefs.setBool('conectado', true);
        //Mensaje al servidor
        //this.controller.login(this.emailValue, this.passwordValue, this.prefs);
        Pedido nuevo = Pedido(0, DateTime.now(), 0, DateTime.now(), "Solicitado");
        Navigator.push(context, MaterialPageRoute(builder: (context)=>HomeScreen(nuevo, this.prefs)));
      }
    }
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Stack(
        children: <Widget>[          
          Gradiant(),
          Container(
            height: MediaQuery.of(context).size.height,
            width: double.infinity,
            margin: EdgeInsets.only(top:5.0),
            child: ListView(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(bottom: 30.0),
                  child: Row(
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
                        padding: const EdgeInsets.only(top: 30),
                        child: Image.asset("assets/img/logo.png",
                          height: 130
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  decoration: BoxDecoration(borderRadius: BorderRadius.only(topLeft: Radius.circular(40), topRight: Radius.circular(40)), color: Color(0xFFFFFEEE),),
                  height: 600, 
                  child: Form(
                    key: formKey,
                    child: Column(
                      children: <Widget> [
                        Padding(
                          padding: const EdgeInsets.only(
                            top: 120,
                            right: 45,
                            left: 45,
                          ),
                          child: TextFormField(
                            keyboardType: TextInputType.emailAddress,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              labelText: "Correo",
                            ),
                            onSaved: (value){
                              emailValue = value!;
                            },
                            validator: (value){
                              if(!this.controller.validateEmail(value!).contains("válido")){
                                return this.controller.validateEmail(value);
                              }
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                            top: 30,
                            right: 45,
                            left: 45,
                          ),
                          child: TextFormField(
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              labelText: "Contraseña",                         
                            ), 
                            onSaved: (value){
                              passwordValue = value!;
                            },
                            validator: (value){
                              if(!this.controller.validatePassword(value!).contains("válido")){
                                return this.controller.validatePassword(value);
                              }
                            },
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
                                ),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = 
                                    ()=>Navigator.push(context,MaterialPageRoute(builder: (context)=>RegisterScreen(this.prefs))),
                                  
                              ),
                            ]
                            ),
                          ),
                        ),
                        GenericButton("Iniciar Sesión", Color(0xFFFD8901), 300, 40, 60, 5, 5, 5, 18, 20, main),
                    ]
                    ),  
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

