class UserController{

String validateEmail(String email){
  RegExp exp = RegExp("[a-zA-Z0-9_\.+]+@(javeriana\.edu\.co)");
  bool matches = exp.hasMatch(email);
  if(email.isEmpty){
    return "Debe ingresar un correro";
  }
  if (!matches)
    return "El correo no pertenece a la Javeriana.";
/*
  if(existe en la BD)
*/
  return "válido";
}

String validatePassword(String password){
  //Validación BD
  
  
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
  /*
  if(existe en la BD) 
  */
}

}