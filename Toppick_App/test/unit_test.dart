import 'package:Toppick_App/Orders/Bloc/order_controller.dart';
import 'package:Toppick_App/Users/Bloc/user_controller.dart';
import 'package:flutter_test/flutter_test.dart';

void main(){
  test('Nombre vacío no es válido', (){
    UserController controller = UserController();
    String nombre = "";
    String result = controller.validateName(nombre);
    expect(result, "El campo no puede quedar vacío");
  });

  test('Nombre con caracteres especiales no es válido', (){
    UserController controller = UserController();
    String nombre = "Juan@fernando";
    String result = controller.validateName(nombre);
    expect(result, "No pueden haber caracteres especiales");
  });
  
  test('Nombre con números no es válido', (){
    UserController controller = UserController();
    String nombre = "Juan 123456";
    String result = controller.validateName(nombre);
    expect(result, "No pueden haber números en su nombre");
  });

  test('Nombre válido no es válido', (){
    UserController controller = UserController();
    String nombre = "Juan Francisco Hamon";
    String result = controller.validateName(nombre);
    expect(result, "válido");
  });

  test('Documento vacío no es válido', (){
    UserController controller = UserController();
    String documento = "";
    String result = controller.validateDocument(documento);
    expect(result, "Debe ingresar un # de documento");
  });

  test('Documento menor a 6 dígitos no es válido', (){
    UserController controller = UserController();
    String documento = "12345";
    String result = controller.validateDocument(documento);
    expect(result, "Número de documento inválido");
  });

  test('Documento mayor a 10 dígitos no es válido', (){
    UserController controller = UserController();
    String documento = "12345678900";
    String result = controller.validateDocument(documento);
    expect(result, "Número de documento inválido");
  });

  test('Documento con texto no es válido', (){
    UserController controller = UserController();
    String documento = "1234567a";
    String result = controller.validateDocument(documento);
    expect(result, "No pueden haber letras");
  });

  test('Documento válido', (){
    UserController controller = UserController();
    String documento = "1122334455";
    String result = controller.validateDocument(documento);
    expect(result, "correcto");
  });

  test('Correo vacío no es válido',(){
    UserController controller = UserController();
    String email = "";
    String result = controller.validateEmail(email);
    expect(result, "Debe ingresar un correro");
  });

  test('Correo no perteneciente a la javeriana no es válido', (){
    UserController controller = UserController();
    String email = "juan@hotmail.com";
    String result = controller.validateEmail(email);
    expect(result, "El correo no pertenece a la Javeriana.");
  });

  test('Correo sin forma no es válido', (){
    UserController controller = UserController();
    String email = "juan1234.com";
    String result = controller.validateEmail(email);
    expect(result, "El correo no pertenece a la Javeriana.");
  });

  test('Correo válido', (){
    UserController controller = UserController();
    String email = "hamon_juan@javeriana.edu.co";
    String result = controller.validateEmail(email);
    expect(result, "válido");
  });

  test('Contraseña vacía no es válida', (){
    UserController controller = UserController();
    String password = "";
    String result = controller.validatePassword(password);
    expect(result, "Debe ingresar una contraseña");
  });

  test('Contraseña sin mayúscula no es válida', (){
    UserController controller = UserController();
    String password = "micontrasena12345";
    String result = controller.validatePassword(password);
    expect(result, "Debe contener al menos una mayúscula");
  });

  test('Contraseña sin minúscula no es válida', (){
    UserController controller = UserController();
    String password = "MICONTRASENA12345";
    String result = controller.validatePassword(password);
    expect(result, "Debe contener al menos una mínuscula");
  });

  test('Contraseña sin número no es válida', (){
    UserController controller = UserController();
    String password = "MiContrasena";
    String result = controller.validatePassword(password);
    expect(result, "Debe contener al menos un número");
  });

  test('Contraseña con caracterse especiales no es válida', (){
    UserController controller = UserController();
    String password = "MiContrasena123#";
    String result = controller.validatePassword(password);
    expect(result, "No debe contener ningún caracter especial");
  });

  test('Constraseña con menos de 8 caracteres no es válida', (){
    UserController controller = UserController();
    String password = "MiCon1";
    String result = controller.validatePassword(password);
    expect(result, "Debe ser de mínimo 8 caracteres");
  });

  test('Contraseña válida', (){
    UserController controller = UserController();
    String password = "Juanfran12345";
    String result = controller.validatePassword(password);
    expect(result, "válido");
  });

  test('Teléfono celular vacío no es válido', (){
    UserController controller = UserController();
    String phone = "";
    String result = controller.validatePhone(phone);
    expect(result, "Debe ingresar un # de celular");
  });

  test('Teléfono celular con letras no est válido', (){
    UserController controller = UserController();
    String phone = "asdf";
    String result = controller.validatePhone(phone);
    expect(result, "No pueden haber letras");
  });

  test('Teléfono con menos de 10 dígitos no es válido', (){
    UserController controller = UserController();
    String phone = "123456";
    String result = controller.validatePhone(phone);
    expect(result, "El # de celular es incorrecto");
  });

  test('Teléfono con más de 10 dígitos no es válido', (){
    UserController controller = UserController();
    String phone = "123456789012";
    String result = controller.validatePhone(phone);
    expect(result, "El # de celular es incorrecto");
  });

  test('Teléfono válido', (){
    UserController controller = UserController();
    String phone = "3040981196";
    String result = controller.validatePhone(phone);
    expect(result, "válido");
  });

  test('Hora para pasar después de la hora de cierre del punto de venta no es válida', (){
    OrderController controller = OrderController();
    DateTime horaPasar = DateTime(2021, 6, 1, 23, 30);
    DateTime horaCierre = DateTime(2021, 6, 1, 19, 30);
    DateTime horaApertura = DateTime(2021, 6, 1, 4, 30);
    bool result = controller.isOutOfRange(horaPasar, horaCierre, horaApertura);
    expect(result, true);
  });

  test('Hora para pasar antes de la hora de apertura del punto de venta no es válida', (){
    OrderController controller = OrderController();
    DateTime horaPasar = DateTime(2021, 6, 1, 3, 30);
    DateTime horaCierre = DateTime(2021, 6, 1, 19, 30);
    DateTime horaApertura = DateTime(2021, 6, 1, 4, 30);
    bool result = controller.isOutOfRange(horaPasar, horaCierre, horaApertura);
    expect(result, true);
  });

  test('Hora para pasar dentro del rango del horario del punto de venta es válida',(){
    OrderController controller = OrderController();
    DateTime horaPasar = DateTime(2021, 6, 1, 10, 30);
    DateTime horaCierre = DateTime(2021, 6, 1, 19, 30);
    DateTime horaApertura = DateTime(2021, 6, 1, 4, 30);
    bool result = controller.isOutOfRange(horaPasar, horaCierre, horaApertura);
    expect(result, false);
  });
}