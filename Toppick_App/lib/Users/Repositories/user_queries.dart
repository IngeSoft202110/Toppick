import 'dart:convert';

import 'package:Toppick_App/Services/push_notifications_service.dart';
import 'package:http/http.dart' as http;

class UserQueries{
  Future<int> login(String email, String password, dynamic prefs) async {
    final response = await http.post(
      Uri.https('toppickapp.herokuapp.com','/usuarios/login'),
      headers: {"Accept": "application/json"},
      body: jsonEncode({
        "nombreUsuario":email,
        "contraseña":password,
        "token": PushNotificationService.token
      })
      );
    if(response.statusCode == 200){
      String cookie = "";
      prefs.setString('cookie', cookie);
      return int.parse(response.body);
    }else{
      return -1;
    }
  }
  
}