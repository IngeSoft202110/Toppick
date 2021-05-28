import 'package:Toppick_App/GeneralUserInterfaces/generic_button.dart';
import 'package:Toppick_App/GeneralUserInterfaces/gradiant.dart';
import 'package:Toppick_App/Orders/Models/pedido.dart';
import 'package:Toppick_App/Users/Models/cliente.dart';
import 'package:Toppick_App/Users/UserInterfaces/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:Toppick_App/Users/Bloc/user_controller.dart';

// ignore: must_be_immutable
class RegisterScreen extends StatelessWidget {
  RegisterScreen(this.prefs);
  final prefs;
  final UserController controller = UserController();

  late String nameValue;
  late String lastNameValue;
  late String documentValue;
  late String userNameValue;
  late String passwordValue;
  late String emailValue;
  late String phoneValue;
  late String dropdownValue = "CC";

  final formKey = GlobalKey<FormState>();

  void notifyParent(String nValue){
    this.dropdownValue = nValue;
  }

  @override
  Widget build(BuildContext context) {
    void main() {
      if (formKey.currentState!.validate()) {
        formKey.currentState!.save();
        Cliente current = Cliente(0, nameValue, int.parse(documentValue), dropdownValue, emailValue, passwordValue, int.parse(phoneValue));
        this.controller.showLoader(context);
        this.controller.register(this.prefs, current).
        then((value) {
          if(value){
            this.prefs.setBool('conectado', true);
            this.prefs.setInt('pedidos actuales', 0);
            this.prefs.setString('nombre', current.nombreCompleto.split(" ")[0]);
            Pedido nuevo = Pedido(0, DateTime.now(), 0, DateTime.now(), "Solicitado");
            Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context)=>HomeScreen(nuevo, this.prefs)), (route) => false);
          }else{
            this.controller.showRegisterError(context);
          }
        }
        );
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
                            labelText: "Nombre completo",
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
                              child: TipoDocumento(notifyParent))),
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
                                    documentValue = value!;
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
                              phoneValue = value!;
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
  TipoDocumento(this.notify, {Key? key}) : super(key: key);
  final Function(String) notify;
  @override
  _TipoDocumentoState createState() => _TipoDocumentoState(this.notify);
}

class _TipoDocumentoState extends State<TipoDocumento> {
  _TipoDocumentoState(this.notify);
  Function(String) notify;
  String dropdownValue = "CC";
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
          notify(dropdownValue);
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
