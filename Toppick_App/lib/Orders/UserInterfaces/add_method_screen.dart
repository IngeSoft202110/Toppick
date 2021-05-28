import 'package:Toppick_App/GeneralUserInterfaces/generic_button.dart';
import 'package:Toppick_App/GeneralUserInterfaces/gradiant.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class AddMethodScreen extends StatelessWidget {
  AddMethodScreen(this.selectedMethodName);
  final String selectedMethodName;
  final formKey = GlobalKey<FormState>();
  String number = "";

  Widget image(){
    if(selectedMethodName == "DaviPlata"){
      return Image.asset("assets/img/daviplata.png", height: 100,);
    }else if(selectedMethodName == "Nequi"){
      return Image.asset("assets/img/nequi.jpg", height: 100,);
    }else{
      return Image.asset("assets/img/pse.jpg", height: 100,);
    }
  }

  void check(){
    if(formKey.currentState!.validate()){
      formKey.currentState!.save();
      //llamado a la funcion de crear un metodo de pago
    }
  }

  @override
  Widget build(BuildContext context) {
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
                                  else if(value.length!=10){
                                    return "Numero de celular invalido";
                                  }else if(!phone && value.length!=20){
                                    return "Numero de cuenta invalido";
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