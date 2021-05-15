//SHA1: C5:57:4E:64:35:D5:F9:A1:37:34:0C:22:37:B4:C6:2C:89:D2:E0:43

import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class PushNotificationService {
  static FirebaseMessaging messaging = FirebaseMessaging.instance;

  static String? token;
  static StreamController<String> _messageStreamController =
      new StreamController.broadcast();

  static Stream<String> get messagesStream => _messageStreamController.stream;

  static Future _backgroundHandler(RemoteMessage message) async {
    alertToDo(message.data);
  }

  static Future _onMessageHandler(RemoteMessage message) async {
    alertToDo(message.data);
  }

  static Future _onMessageOpenApp(RemoteMessage message) async {
    alertToDo(message.data);
  }

  static Future initializeApp() async {
    //push Notifications
    await Firebase.initializeApp();
    token = await FirebaseMessaging.instance.getToken();
    await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );
    //Mandar token a la bd :3
    print('Token $token');

    //handlers
    FirebaseMessaging.onBackgroundMessage(_backgroundHandler);
    FirebaseMessaging.onMessage.listen(_onMessageHandler);
    FirebaseMessaging.onMessageOpenedApp.listen(_onMessageOpenApp);
    //Local Notification
  }

  static closeStreams() {
    _messageStreamController.close();
  }

  static void alertToDo(var objeto) {
    String argumento = 'no-data';
    argumento = objeto['estadoPedido'] ?? 'no-data';
    _messageStreamController.add(argumento);
  }
}
