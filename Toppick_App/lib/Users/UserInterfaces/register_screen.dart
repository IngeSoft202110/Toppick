import 'package:Toppick_App/GeneralUserInterfaces/generic_button.dart';
import 'package:Toppick_App/GeneralUserInterfaces/gradiant.dart';
import 'package:Toppick_App/Users/UserInterfaces/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:Toppick_App/Users/Bloc/user_controller.dart';
import 'package:intl/intl.dart';

// ignore: must_be_immutable
class RegisterScreen extends StatelessWidget {
  RegisterScreen(this.prefs);
  final prefs;
  final UserController controller = UserController();

  late String nameValue;
  late String lastNameValue;
  late NumberFormat documentValue;
  late String userNameValue;
  late String passwordValue;
  late String emailValue;
  late NumberFormat phoneValue;
  late String dropdownValue;
  late List listItem = ["C.C.", "T.I.", "C.E."];

  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    void main() {
      if (formKey.currentState!.validate()) {
        formKey.currentState!.save();
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => LoginScreen(this.prefs)));
      }
    }

    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Stack(children: <Widget>[
        Gradiant(),
        Container(
          height: MediaQuery.of(context).size.height,
          width: double.infinity,
          margin: EdgeInsets.only(top: 5.0),
          child: ListView(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(bottom: 30),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        "Regístrate",
                        style: TextStyle(
                            height: 6, fontSize: 30, color: Colors.white),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 70),
                        child: Image.asset("assets/img/logo.png", height: 130),
                      ),
                    ],
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(40),
                        topRight: Radius.circular(40)),
                    color: Color(0xFFFFFEEE),
                  ),
                  child: Form(
                    key: formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
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
                            labelText: "Nombre",
                          ),
                          onSaved: (value) {
                            nameValue = value!;
                          },
                          validator: (value) {
                            if (!this.controller.isEmpty(value!).contains("válido")) {
                              return this.controller.isEmpty(value);
                            }
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          top: 10,
                          right: 45,
                          left: 45,
                        ),
                        child: TextFormField(
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            labelText: "Apellido",
                          ),
                          onSaved: (value) {
                            lastNameValue = value!;
                          },
                          validator: (value) {
                            if (!this.controller.isEmpty(value!).contains("válido")) {
                              return this.controller.isEmpty(value);
                            }
                          },
                        ),
                      ),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Flexible(flex: 1,
                            child:
                            Padding(
                              padding: const EdgeInsets.only(
                                top: 10,
                                left: 45
                              ), 
                              child: TipoDocumento())),
                            Flexible(
                              flex: 3,
                              child: Padding(
                                padding: const EdgeInsets.only(
                                  top: 10,
                                  right: 45,
                                  left: 5
                                ),
                                child: TextFormField(
                                  keyboardType: TextInputType.number,
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    labelText: "Documento",
                                  ),
                                  onSaved: (value) {
                                    documentValue = value! as NumberFormat;
                                  },
                                  validator: (value) {
                                    if (!this.controller.validateDocument(value!).contains("correcto")) {
                                      return this.controller.validateDocument(value);
                                    }
                                  },
                                ),
                              ),
                            ),
                            
                          ]),
                        Padding(
                          padding: const EdgeInsets.only(
                            top: 10,
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
                            obscureText: true,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                            top: 10,
                            right: 45,
                            left: 45,
                          ),
                          child: TextFormField(
                            keyboardType: TextInputType.visiblePassword,
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
                            top: 10,
                            right: 45,
                            left: 45,
                          ),
                          child: TextFormField(
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              labelText: "Celular",                         
                            ), 
                            onSaved: (value){
                              phoneValue = value! as NumberFormat;
                            },
                            validator: (value){
                              if(!this.controller.validatePhone(value!).contains("válido")){
                                return this.controller.validatePhone(value);
                              }
                            },
                          ),
                        ),
                      GenericButton("Registrate", Color(0xFFFD8901), 300, 40,
                          50, 5, 85, 5, 18, 20, main),
                    ]),
                  ),
                ),
              ]),
        ),
      ]),
    );
  }
}

class TipoDocumento extends StatefulWidget {
  TipoDocumento({Key? key}) : super(key: key);
  @override
  _TipoDocumentoState createState() => _TipoDocumentoState();
}

class _TipoDocumentoState extends State<TipoDocumento> {
  String dropdownValue = 'CC';
  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      value: dropdownValue,
      icon: const Icon(Icons.arrow_drop_down),
      iconSize: 20,
      elevation: 16,
      onChanged: (String? newValue) {
        setState(() {
          dropdownValue = newValue!;
          print(dropdownValue);
        });
      },
      items: <String>['CC', 'TI', 'CE']
          .map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }
}
