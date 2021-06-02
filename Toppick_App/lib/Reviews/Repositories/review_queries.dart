import 'dart:convert';

import 'package:Toppick_App/Reviews/Models/rewiew.dart';
import 'package:http/http.dart' as http;

class ReviewQueries{
  String domain = 'toppickapp.herokuapp.com';

  Future<List<Resena>> getShopReviews(String cookie, int shopId) async {
    final response = await http.get(
      Uri.https(this.domain, '/resena/tienda/$shopId'),
      headers: {"Accept": "application/json", "Cookie":cookie}
    );
    if(response.statusCode == 200){
      return parseReviews(response.body);
    }else{
      return [];
    }
  }

  Future<bool> publishShopReview(String cookie, int shopId, Resena review) async {
    final response = await http.post(
      Uri.https(this.domain, '/resena/tienda/$shopId'),
      headers: {"Accept": "application/json", "Cookie":cookie, "content-type": "application/json"},
      body: jsonEncode({
        "calificacion": review.calificacion,
        "descripcion": review.descripcion
      })
    );
    if(response.statusCode == 200){
      return true;
    }else{
      return false;
    }
  }

  Future<List<Resena>> getProductReviews(String cookie, int productId) async {
    final response = await http.get(
      Uri.https(this.domain, '/resena/producto/$productId'),
      headers: {"Accept": "application/json", "Cookie":cookie}
    );
    print(response.body);
    if(response.statusCode == 200){
      return parseReviews(response.body);
    }else{
      return [];
    }
  }

  Future<bool> publishProductReview(String cookie, int productId, Resena review) async {
    final response = await http.post(
      Uri.https(this.domain, '/resena/producto/$productId'),
      headers: {"Accept": "application/json", "Cookie":cookie, "content-type": "application/json"},
      body: jsonEncode({
        "calificacion": review.calificacion,
        "descripcion": review.descripcion
      })
    );
    if(response.statusCode == 200){
      return true;
    }else{
      return false;
    }
  }

  List<Resena> parseReviews(String responseBody){
    List<Resena> result = [];
    final first = json.decode(responseBody);
    final parsed = first['body'];
    double calificacion = parsed['calificacion'].toDouble();
    for(var val in parsed['reseñas']){
      result.add(Resena.fromJson(val, calificacion));
    }
    return result;
  }
}