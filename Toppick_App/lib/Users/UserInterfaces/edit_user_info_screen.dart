import 'package:Toppick_App/GeneralUserInterfaces/generic_button.dart';
import 'package:Toppick_App/GeneralUserInterfaces/gradiant.dart';
import 'package:Toppick_App/Orders/Models/pedido.dart';
import 'package:Toppick_App/Users/Bloc/user_controller.dart';
import 'package:Toppick_App/Users/Models/cliente.dart';
import 'package:Toppick_App/Users/UserInterfaces/profile.dart';
import 'package:Toppick_App/Users/UserInterfaces/register_screen.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class EditUserInfoScreen extends StatelessWidget {
  EditUserInfoScreen(this.actual, this.prefs, this.current);
  final Cliente actual;
  String nNames = "";
  String nDocument = "";
  String nPhone = "";
  String dropdownValue = "";
  final formKey = GlobalKey<FormState>();
  final UserController controller = UserController();
  final prefs;
  final Pedido current;

  void notifyParent(String nValue){
    this.dropdownValue = nValue;
  }

  @override
  Widget build(BuildContext context) {
    
    this.dropdownValue = this.actual.tipoDocumento;
    void check(){
      if (formKey.currentState!.validate()){
        formKey.currentState!.save();
        this.controller.showLoader(context);
        this.controller.updateUserInfo(this.prefs.getString('cookie'), this.nNames, this.dropdownValue, this.nDocument, this.nPhone).then(
          (value){
            if(value){
              this.prefs.setString('nombre', this.nNames.split(" ")[0]);
              this.controller.showCorrectUpdateUserInfo(context, this.current, this.prefs);
            }else{
              this.controller.showUpdateUserInfoError(context);
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
        resizeToAvoidBottomInset: true,
        body: Stack(
          children: <Widget>[
            Gradiant(),
            Container(
              height: MediaQuery.of(context).size.height,
              width: double.infinity,
              child: ListView(
                children: <Widget>[
                  Container(
                    padding: const EdgeInsets.all(10.0),
                    child: Center(
                      child: Text("Editar perfil", style: TextStyle(color: Colors.white, fontSize: 35, fontWeight: FontWeight.bold),)
                    )
                  ),
                  Container(
                    padding: const EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(Icons.person, size: 100,),
                  ),
                  Divider(color: Color(0xFFFD8901),),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(40),
                          topRight: Radius.circular(40)),
                      color: Color(0xFFFFFEEE),
                    ),
                    child: Form(
                      key: this.formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            padding: const EdgeInsets.only(top: 20.0, left: 15.0),
                            child: Center(
                              child: Text("Tus datos", style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold))
                            )
                          ),
                          Container(
                            padding: const EdgeInsets.only(top: 10.0, left: 15.0),
                            child: Text("Nombres", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold))
                          ),
                          Container(
                            padding: const EdgeInsets.only(top: 10.0, left: 15, right: 15, bottom: 5.0),
                            child: TextFormField(
                              initialValue: this.actual.nombreCompleto,
                              keyboardType: TextInputType.visiblePassword,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                labelText: "Nombre completo",
                              ),
                              onSaved: (value){
                                this.nNames = value!;
                              },
                              validator: (value){
                                if(value!.isEmpty){
                                  return "Ingrese la información";
                                }
                                else if (value.contains(new RegExp(r'[!@#$%^(),.?":{}|<>]'))){
                                  return "Sin caracteres especiales";
                                }
                                else if (value.contains(new RegExp(r'[0-9]'))){
                                  return "No pueden haber números en su nombre";
                                }
                              },
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.only(top: 10.0, left: 15.0),
                            child: Text("Identificación", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold))
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Flexible(flex: 1,
                                child:
                                Container(
                                  padding: const EdgeInsets.only(top: 10, left: 15), 
                                  child: TipoDocumento(notifyParent, this.dropdownValue)
                                )
                              ),
                              Flexible(
                                flex: 3,
                                child: Container(
                                  padding: const EdgeInsets.only(top: 10, right: 5),
                                  child: TextFormField(
                                    initialValue: this.actual.documento.toString(),
                                    keyboardType: TextInputType.number,
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      labelText: "Documento",
                                    ),
                                    onSaved: (value) {
                                      this.nDocument= value!;
                                    },
                                    validator: (value) {
                                      if(value!.isEmpty){
                                        return "Ingrese la información";
                                      }
                                      if (!this.controller.validateDocument(value).contains("correcto")) {
                                        return this.controller.validateDocument(value);
                                      }
                                    },
                                  ),
                                ),
                              ),
                              
                            ]
                          ),
                          Container(
                            padding: const EdgeInsets.only(top: 10.0, left: 15.0),
                            child: Text("Teléfono", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold))
                          ),
                          Container(
                            padding: const EdgeInsets.only(top: 10.0, left: 15, right: 15, bottom: 5.0),
                            child: TextFormField(
                              initialValue: this.actual.celular.toString(),
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                labelText: "Teléfono",
                              ),
                              onSaved: (value){
                                this.nPhone = value!;
                              },
                              validator: (value){
                                if(value!.isEmpty){
                                  return "Ingrese la información";
                                }
                                if(!this.controller.validatePhone(value).contains("válido")){
                                  return this.controller.validatePhone(value);
                                }
                              },
                            ),
                          ),
                          Center(
                            child: GenericButton("Guardar cambios", Color(0XFF0CC665), 250, 40, 30, 10, 10, 10, 25, 15, check)
                          ),
                          Center(
                            child: GenericButton("Volver", Color(0xFF2196F3), 250, 40, 10, 10, 10, 10, 25, 15, back)
                          )
                        ],
                      ),
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