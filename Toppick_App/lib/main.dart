import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'UserInterfaces/gradiant.dart';
import 'UserInterfaces/search_bar_button.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Colors.transparent, // transparent status bar
  ));
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Toppick App',
        theme: ThemeData(
          primarySwatch: Colors.deepOrange,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          body: Stack(
            children: [
              Gradiant(),
              Column(
                children: [
                  SearchButton("Buscar Tienda/Producto", 1),
                  SearchButton("Buscar Tienda", 2),
                  SearchButton("Buscar Producto", 3),
                ],
              ),
            ],
          ),
        ));
  }
}
