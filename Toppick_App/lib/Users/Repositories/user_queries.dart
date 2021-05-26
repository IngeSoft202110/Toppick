import 'package:Toppick_App/Services/push_notifications_service.dart';
import 'package:http/http.dart' as http;

class UserQueries{
  String domain = 'toppickapp.herokuapp.com';

  Future<bool> login(String email, String password, dynamic prefs) async {
    final response = await http.post(
      Uri.https(this.domain,'/usuarios/login'),
      headers: {"Accept": "application/json"},
      body: {
        "nombreUsuario":email,
        "contraseña":password,
        "token": PushNotificationService.token
      }
      );
    if(response.statusCode == 200){
      String? cookie = response.headers['set-cookie'];
      if(cookie != null){
        int index = cookie.indexOf(";");
        String finalCookie = "";
        (index == -1)? finalCookie = cookie : finalCookie = cookie.substring(0, index);
        prefs.setString('cookie', finalCookie);
        print("Cookie: ${prefs.getString('cookie')}");
        return true;
      }
      else{
        print("False por cookie");
        return false;
      }
    }else{
      print("False por error en peticion");
      return false;
    }
  }
  
  Future<bool> logout(dynamic prefs) async {
    final response = await http.get(
      Uri.https(this.domain, '/usuarios/logout'),
      headers: {"Accept": "application/json", "Cookie":prefs.getString('cookie')}
    );
    if(response.statusCode == 200){
      return true;
    }else{
      return false;
    }
  }
}