import 'package:Toppick_App/GeneralUserInterfaces/generic_button.dart';
import 'package:Toppick_App/GeneralUserInterfaces/gradiant.dart';
import 'package:Toppick_App/Orders/Models/pedido.dart';
import 'package:Toppick_App/Users/Bloc/user_controller.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class AddMethodScreen extends StatelessWidget {
  AddMethodScreen(this.selectedMethodName, this.prefs, this.current, this.namePageParent);
  final String selectedMethodName;
  final formKey = GlobalKey<FormState>();
  String number = "";
  final prefs;
  final Pedido current;
  final UserController controller = UserController();
  final String namePageParent;

  Widget image(){
    if(selectedMethodName == "Daviplata"){
      return Image.asset("assets/img/daviplata.png", height: 100,);
    }else if(selectedMethodName == "Nequi"){
      return Image.asset("assets/img/nequi.jpg", height: 100,);
    }else{
      return Image.asset("assets/img/pse.jpg", height: 100,);
    }
  }


  @override
  Widget build(BuildContext context) {
    void check(){
      if(formKey.currentState!.validate()){
        formKey.currentState!.save();
        this.controller.showLoader(context);
        this.controller.registerregisterPaymentMethod(this.prefs.getString('cookie'), this.number, this.selectedMethodName).
        then((value) {
          if(value){
            this.controller.showCorrectAddMethod(context, this.namePageParent, this.current, this.prefs, 0);
          }else{
            this.controller.showAddMethodError(context);
          }
        });
      }
    }
    bool phone = (this.selectedMethodName=="PSE")?false:true;
    return Scaffold(
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
                      Flexible(child: Center(child: Text("Agregar método de pago", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 30),))),
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
                        child: image(),
                      ),
                      Form(
                        key: this.formKey,
                        child: Column(
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.only(top: 5.0, left: 30, right: 30),
                              child: TextFormField(
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
                          ],
                        )
                      ),
                      GenericButton("Registrar", Color(0xFFFD8901), 250, 40, 30, 10, 10, 10, 25, 15, check),
                      GenericButton("Volver", Color(0xFF2196F3), 250, 40, 10, 10, 10, 10, 25, 15, ()=>{Navigator.of(context).pop()})
                    ],
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