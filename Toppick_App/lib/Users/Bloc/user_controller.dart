import 'package:Toppick_App/Users/Repositories/user_queries.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class UserController{
  UserQueries userQueries = new UserQueries();

  UserController(){
    this.userQueries = new UserQueries();
  }

  String validateEmail(String email){
    RegExp exp = RegExp("[a-zA-Z0-9_\.+]+@(javeriana\.edu\.co)");
    bool matches = exp.hasMatch(email);
    if(email.isEmpty){
      return "Debe ingresar un correro";
    }
    if (!matches)
      return "El correo no pertenece a la Javeriana.";
    return "válido";
  }

  String validatePassword(String password){
    if(password.isEmpty){
      return "Debe ingresar una contraseña";
    }
    if(!password.contains(new RegExp(r'[A-Z]')))
      return "Debe contener al menos una mayúscula";
    else if (!password.contains(new RegExp(r'[a-z]')))
      return "Debe contener al menos una mínuscula";
    else if (!password.contains(new RegExp(r'[0-9]')))
      return "Debe contener al menos un número";
    else if (password.contains(new RegExp(r'[!@#$%^(),.?":{}|<>]')))
      return "No debe contener ningún caracter especial";
    else if (password.length < 8)
      return "Debe ser de mínimo 8 caracteres";
    else
      return "válido";
  }

  String isEmpty(String value){
    if(value.isEmpty)
      return "El campo no puede quedar vacío";
    else
      return "válido";
  }

  String validateDocument(String document){
    if(document.isEmpty)
      return "Debe ingresar un # de documento";
    else if(document.length < 6 || document.length > 10)
      return "Número de documento inválido";
    else
      return "correcto";
  }

  String validatePhone(String phone){
    if(phone.isEmpty)
      return "Debe ingresar un # de celular";
    else if (phone.length != 10)
      return "El # de celular es incorrecto";
    else
      return "válido";
  }

  Future<bool> login(String email, String password, dynamic prefs){
    return this.userQueries.login(email, password, prefs);
  }

  Future<bool> logout(dynamic prefs){
    return this.userQueries.logout(prefs);
  }

  showLoader(BuildContext context){
    AlertDialog alert = AlertDialog(
      content: Container(height: 150, child: CircularProgressIndicator())
    );
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context){
        return alert;
      }
    );
  }

  showError(BuildContext context) {
    Navigator.of(context).pop();
    Widget okButton = TextButton(
      child: Text("OK"),
      onPressed: () { Navigator.of(context).pop();},
    );
    AlertDialog alert = AlertDialog(
      title: Text("Error al intentar cerrar sesión", style: TextStyle(color: Color(0xFFD76060)),),
      content: Text("Ha ocurrido un error al cerrar la sesión"),
      actions: [
        okButton,
      ],
    );
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  showLoginError(BuildContext context) {
    Navigator.of(context).pop();
    Widget okButton = TextButton(
      child: Text("OK"),
      onPressed: () { Navigator.of(context).pop();},
    );
    AlertDialog alert = AlertDialog(
      title: Text("Error al intentar iniciar sesión", style: TextStyle(color: Color(0xFFD76060)),),
      content: Text("Ha ocurrido un error al iniciar la sesión"),
      actions: [
        okButton,
      ],
    );
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

}