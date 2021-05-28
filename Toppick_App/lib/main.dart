import 'package:Toppick_App/Orders/Models/pedido.dart';
import 'package:Toppick_App/Orders/UserInterfaces/active_orders_home.dart';
import 'package:Toppick_App/Orders/UserInterfaces/order_history_home.dart';
import 'package:Toppick_App/Services/push_notifications_service.dart';
import 'package:Toppick_App/Users/UserInterfaces/home_screen.dart';
import 'package:Toppick_App/Users/UserInterfaces/main_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await PushNotificationService.initializeApp();
  final prefs = await SharedPreferences.getInstance();
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Colors.transparent, // transparent status bar
  ));
  runApp(MyApp(prefs));
}

class MyApp extends StatefulWidget {
  MyApp(this.prefs);
  final prefs;
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final GlobalKey<NavigatorState> navigatorKey =
      new GlobalKey<NavigatorState>();
  late Widget resultPage;
  @override
  void initState() {
    super.initState();

    PushNotificationService.messagesStream.listen((message) {
      //Se deja en la pagina de inicio y se borra todo lo anterior, con esto ya luego se redirige a la que sigue dependiendo del estado
      navigatorKey.currentState?.pushAndRemoveUntil(MaterialPageRoute(builder: (context) => MainPage(widget.prefs)), (route) => false);
      if (message == "Rechazado" || message == "Terminado")
        navigatorKey.currentState?.pushNamed('historial');
      else
        navigatorKey.currentState?.pushNamed('activos');
    });
    
    //Test SharedPreferences
    final conected = widget.prefs.getBool('conectado');
    if(conected == null){
      resultPage = MainPage(widget.prefs);
      print("No esta conectado");
    }else{
      Pedido nuevo = Pedido(0, DateTime.now(), 0, DateTime.now(), "Solicitado");
      resultPage = HomeScreen(nuevo, widget.prefs);
      print("Esta conectado");
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Toppick App',
      theme: ThemeData(
        primarySwatch: Colors.deepOrange,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      debugShowCheckedModeBanner: false,
      routes: {
        'activos': (BuildContext context) => ActiveOrdersHome(
          Pedido(0, DateTime.now(), 0, DateTime.now(), "Solicitado"), widget.prefs),
        'historial': (BuildContext context) => OrderHistoryHome(
          Pedido(0, DateTime.now(), 0, DateTime.now(), "Solicitado"), widget.prefs),
      },
      navigatorKey: navigatorKey,
      home: Scaffold(body: resultPage));
  }
}
