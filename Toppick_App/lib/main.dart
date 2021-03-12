import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'UserInterfaces/home_product.dart';
//import 'UserInterfaces/home_screen.dart';
import 'UserInterfaces/shopcategorylist.dart';
import 'UserInterfaces/productlist.dart';

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
        home: Scaffold(body: HomeProduct()));
  }
}
