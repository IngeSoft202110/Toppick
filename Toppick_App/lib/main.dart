import 'package:Toppick_App/Orders/Models/pedido.dart';
import 'package:Toppick_App/Orders/UserInterfaces/active_orders_home.dart';
import 'package:Toppick_App/Services/push_notifications_service.dart';
import 'package:Toppick_App/Users/UserInterfaces/main_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'Orders/UserInterfaces/order_history_home.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await PushNotificationService.initializeApp();
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Colors.transparent, // transparent status bar
  ));
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final GlobalKey<NavigatorState> navigatorKey =
      new GlobalKey<NavigatorState>();

  @override
  void initState() {
    super.initState();
    //context

    //aqui fran pone lo de popear todo lo de la cola alv :V until la pantalla principal xd
    PushNotificationService.messagesStream.listen((message) {
      bool? a = (navigatorKey.currentState?.canPop() != null)
          ? navigatorKey.currentState?.canPop()
          : false;

      if (a != null) if (a) navigatorKey.currentState?.pop();

      if (message == "Rechazado" || message == "Terminado")
        navigatorKey.currentState?.pushNamed('historial');
      else
        navigatorKey.currentState?.pushNamed('activos');
    });
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
              Pedido(0, DateTime.now(), 0, DateTime.now(), "Solicitado")),
          'historial': (BuildContext context) => OrderHistoryHome(
              Pedido(0, DateTime.now(), 0, DateTime.now(), "Solicitado")),
        },
        navigatorKey: navigatorKey,
        home: Scaffold(body: MainPage()));
  }
}
