import 'package:Toppick_App/Orders/Models/pedido.dart';
import 'package:Toppick_App/Orders/UserInterfaces/order_card.dart';
import 'package:Toppick_App/Users/Models/cliente.dart';
import 'package:Toppick_App/Users/Repositories/user_queries.dart';
import 'package:Toppick_App/Users/UserInterfaces/profile.dart';
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

  Future<bool> register(dynamic prefs, Cliente user){
    return this.userQueries.register(prefs, user);
  }

  Future<Cliente> getUserInfo(String cookie, String email) {
    return this.userQueries.getUserInfo(cookie, email);
  }

  Future<bool> updateUserInfo(String cookie, String nName, String nType, String document, String number){
    return this.userQueries.updateUserInfo(cookie, nName, nType, document, number);
  }

  Future<dynamic> getPaymentMethods(String cookie) {
    return this.userQueries.getPaymentMethods(cookie);
  }

  Future<bool> registerregisterPaymentMethod(String cookie, String number, String name){
    return this.userQueries.registerPaymentMethod(cookie, number, name);
  }

  Future<bool> updatePaymentMethod(String cookie, String methodName, int id, int toAdd, int current){
    return this.userQueries.updatePaymentMethod(cookie, methodName, id, toAdd, current);
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

  showRegisterError(BuildContext context) {
    Navigator.of(context).pop();
    Widget okButton = TextButton(
      child: Text("OK"),
      onPressed: () { Navigator.of(context).pop();},
    );
    AlertDialog alert = AlertDialog(
      title: Text("Error al intentar registrarse", style: TextStyle(color: Color(0xFFD76060)),),
      content: Text("Ha ocurrido un error al realizar el registro"),
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

  showAddMethodError(BuildContext context) {
    Navigator.of(context).pop();
    Widget okButton = TextButton(
      child: Text("OK"),
      onPressed: () { Navigator.of(context).pop();},
    );
    AlertDialog alert = AlertDialog(
      title: Text("Error al intentar registrar el método de pago", style: TextStyle(color: Color(0xFFD76060)),),
      content: Text("Ha ocurrido un error al realizar el registro del método de pago"),
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

  showCorrectAddMethod(BuildContext context, String screen, Pedido current, dynamic prefs, dynamic hKey) {
    Widget okButton = TextButton(
      child: Text("OK"),
      onPressed: () { 
        Navigator.of(context).pop(); //Alerta
        Navigator.of(context).pop(); //Formulario informacion
        Navigator.of(context).pop(); //Pantalla seleccion
        Navigator.of(context).pop(); //Pantalla "actual"
        if(screen == "Perfil"){
          Navigator.push(
            context, MaterialPageRoute(builder: (context) => Profile(current, prefs)));
        }else if(screen == "Pedido"){
          Navigator.push(
            context, MaterialPageRoute(builder: (context) => OrderCard(current, hKey)));
        }
      },
    );
    AlertDialog alert = AlertDialog(
      title: Text("Registro completado de forma correcta", style: TextStyle(color: Color(0xFF0CC665)),),
      content: Text("Su método de pago se ha registrado de forma correcta"),
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

  showUpdateMethodError(BuildContext context) {
    Navigator.of(context).pop();
    Widget okButton = TextButton(
      child: Text("OK"),
      onPressed: () { Navigator.of(context).pop();},
    );
    AlertDialog alert = AlertDialog(
      title: Text("Error en actualización información del método de pago", style: TextStyle(color: Color(0xFFD76060)),),
      content: Text("Ha ocurrido un error al intentar actualizar la información del método de pago"),
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

  showCorrectUpdateMethod(BuildContext context, Pedido current, dynamic prefs) {
    Widget okButton = TextButton(
      child: Text("OK"),
      onPressed: () { 
        Navigator.of(context).pop(); //Alerta
        Navigator.of(context).pop(); //Formulario actualizar
        Navigator.of(context).pop(); //Pantalla perfil
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => Profile(current, prefs)));
      },
    );
    AlertDialog alert = AlertDialog(
      title: Text("Actualización completada correctamente", style: TextStyle(color: Color(0xFF0CC665)),),
      content: Text("La información de su método de pago se ha actualizado de forma correcta"),
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

  showUpdateUserInfoError(BuildContext context) {
    Navigator.of(context).pop();
    Widget okButton = TextButton(
      child: Text("OK"),
      onPressed: () { Navigator.of(context).pop();},
    );
    AlertDialog alert = AlertDialog(
      title: Text("Error en actualización información perfil", style: TextStyle(color: Color(0xFFD76060)),),
      content: Text("Ha ocurrido un error al intentar actualizar la información de su perfil"),
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

  showCorrectUpdateUserInfo(BuildContext context, Pedido current, dynamic prefs) {
    Widget okButton = TextButton(
      child: Text("OK"),
      onPressed: () { 
        Navigator.of(context).pop(); //Alerta
        Navigator.of(context).pop(); //Formulario actualizar
        Navigator.of(context).pop(); //Pantalla perfil
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => Profile(current, prefs)));
      },
    );
    AlertDialog alert = AlertDialog(
      title: Text("Actualización completada correctamente", style: TextStyle(color: Color(0xFF0CC665)),),
      content: Text("La información de su perfil se ha actualizado de forma correcta"),
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