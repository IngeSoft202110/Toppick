import 'package:Toppick_App/GeneralUserInterfaces/generic_button.dart';
import 'package:Toppick_App/GeneralUserInterfaces/gradiant.dart';
import 'package:Toppick_App/Orders/Models/daviplata.dart';
import 'package:Toppick_App/Orders/Models/nequi.dart';
import 'package:Toppick_App/Orders/Models/pedido.dart';
import 'package:Toppick_App/Orders/Models/pse.dart';
import 'package:Toppick_App/Users/Bloc/user_controller.dart';
import 'package:Toppick_App/Users/UserInterfaces/profile.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class EditMethodScreen extends StatelessWidget {
  EditMethodScreen(this.metodo, this.prefs, this.current);
  final dynamic metodo;
  final prefs;
  final Pedido current;
  final formKey = GlobalKey<FormState>();
  String number = "";
  String toAdd = "";
  String name = "";
  final UserController controller = UserController();

  Widget text(){
    if(metodo is DaviPlata){
      name = "Daviplata";
      return Text("DaviPlata", style: TextStyle(fontSize: 45, fontWeight: FontWeight.bold, color: Color(0xFFD76060),));
    }else if(metodo is Nequi){
      name = "Nequi";
      return Text("Nequi", style: TextStyle(fontSize: 45, fontWeight: FontWeight.bold, color: Color(0xFFD76060),));
    }else{
      name = "PSE";
      return Text("PSE", style: TextStyle(fontSize: 45, fontWeight: FontWeight.bold, color: Color(0xFFD76060),));
    }
  }

  @override
  Widget build(BuildContext context) {
    bool phone = (this.metodo is PSE)?false:true;

    void check(){
      if(formKey.currentState!.validate()){
        formKey.currentState!.save();
        this.controller.showLoader(context);
        this.controller.updatePaymentMethod(this.prefs.getString('cookie'), this.name, int.parse(this.number), int.parse(this.toAdd), this.metodo.availableAmount).then(
          (value) {
            if(value){
              this.controller.showCorrectUpdateMethod(context, this.current, this.prefs);
            }else{
              this.controller.showUpdateMethodError(context);
            }
          }
        );
      }
    }

    final back =(){
      Navigator.pop(context);
      Navigator.push(context, MaterialPageRoute(builder: (context) => Profile(this.current, this.prefs)));
    };

    return WillPopScope(
      onWillPop: () async{
        return false;
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Stack(
          children: <Widget>[
            Gradiant(),
            Container(
              height: MediaQuery.of(context).size.height,
              width: double.infinity,
              child: Column(
                children: <Widget>[
                  Container(
                    height: MediaQuery.of(context).size.height*0.30,
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        Flexible(child: Center(child: Text("Editar método de pago", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 30),))),
                        Image.asset("assets/img/logo.png",
                          height: 130
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: MediaQuery.of(context).size.height*0.70,
                    width: double.infinity,
                    decoration: BoxDecoration(borderRadius: BorderRadius.only(topLeft: Radius.circular(40), topRight: Radius.circular(40)), color: Colors.white),
                    child: Column(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(top: 15.0, bottom: 10.0),
                          child: text(),
                        ),
                        Form(
                          key: this.formKey,
                          child: Column(
                            children: [
                              Container(
                                padding: const EdgeInsets.only(top: 5.0, left: 30, right: 30, bottom: 10.0),
                                child: TextFormField(
                                  initialValue: (phone)?this.metodo.numeroCelular.toString():this.metodo.numeroCuenta.toString(),
                                  keyboardType: TextInputType.number,
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    labelText: (phone)?"Celular":"Número cuenta",
                                  ),
                                  onSaved: (value){
                                    this.number = value!;
                                  },
                                  validator: (value){
                                    if(value!.isEmpty){
                                      return "Ingrese la información";
                                    }
                                    else if(!value.contains(new RegExp(r'^[0-9]*$'))){
                                      return "Solo pueden ser números";
                                    }else if(value.contains(new RegExp(r'[!@#$%^(),.?":{}|<>]'))){
                                      return "No deben haber caracteres especiales";
                                    }
                                    else if(value.length!=10){
                                      return "Tamaño invalido";
                                    }
                                  },
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.only(top: 5.0, left: 30, right: 30),
                                child: TextFormField(
                                  initialValue: "0",
                                  keyboardType: TextInputType.number,
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    labelText: "Valor a agregar a la cuenta (COP)",
                                  ),
                                  onSaved: (value){
                                    this.toAdd = value!;
                                  },
                                  validator: (value){
                                    if(value!.isEmpty){
                                      return "Ingrese la información";
                                    }
                                    else if(!value.contains(new RegExp(r'^[0-9]*$'))){
                                      return "Solo pueden ser números";
                                    }else if(value.contains(new RegExp(r'[!@#$%^(),.?":{}|<>]'))){
                                      return "No deben haber caracteres especiales";
                                    }else if(int.parse(value) < 0){
                                      return "No puede poner dinero negativo";
                                    }else if(value.length > 6){
                                      return "Cantidad muy grande para transacción";
                                    }
                                  },
                                ),
                              )
                            ],
                          ),
                        ),
                        GenericButton("Guardar cambios", Color(0XFF0CC665), 250, 40, 30, 10, 10, 10, 25, 15, check),
                        GenericButton("Volver", Color(0xFF2196F3), 250, 40, 10, 10, 10, 10, 25, 15, back)
                      ],
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}