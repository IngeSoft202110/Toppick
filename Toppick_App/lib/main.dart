import 'package:Toppick_App/Orders/Models/pedido.dart';
import 'package:Toppick_App/Users/UserInterfaces/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Colors.transparent, // transparent status bar
  ));
  runApp(MyApp());
}

Pedido current = Pedido(0, DateTime.now(), 0, 0, "En proceso");

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    current.carrito.clear();
    return MaterialApp(
        title: 'Toppick App',
        theme: ThemeData(
          primarySwatch: Colors.deepOrange,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        debugShowCheckedModeBanner: false,
        home: Scaffold(body: HomeScreen(current)));
  }
}
