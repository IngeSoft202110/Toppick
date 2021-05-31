import 'package:Toppick_App/Reviews/Models/rewiew.dart';
import 'package:Toppick_App/Reviews/Repositories/review_queries.dart';
import 'package:Toppick_App/Reviews/UserInterfaces/shop_review_screen.dart';
import 'package:Toppick_App/Shops/Models/tienda.dart';
import 'package:flutter/material.dart';

class ReviewController{
  ReviewQueries reviewQueries = ReviewQueries();

  ReviewController(){
    this.reviewQueries = new ReviewQueries();
  }

  Future<List<Resena>> getShopReviews(String cookie, int shopId){
    return this.reviewQueries.getShopReviews(cookie, shopId);
  }

  Future<bool> publishShopReview(String cookie, int shopId, Resena review){
    return this.reviewQueries.publishShopReview(cookie, shopId, review);
  }

  showLoader(BuildContext context){
    AlertDialog alert = AlertDialog(
      content: Container(height: 150, child: CircularProgressIndicator())
    );
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context){
        return alert;
      }
    );
  }

  showPublishShopReviewError(BuildContext context) {
    Navigator.of(context).pop();
    Widget okButton = TextButton(
      child: Text("OK"),
      onPressed: () { Navigator.of(context).pop();},
    );
    AlertDialog alert = AlertDialog(
      title: Text("Error al intentar opinar", style: TextStyle(color: Color(0xFFD76060)),),
      content: Text("Ha ocurrido un error al intentar enviar la reseña"),
      actions: [
        okButton,
      ],
    );
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  showCorrectPublishShopReview(BuildContext context, Tienda shop, dynamic prefs) {
    Widget okButton = TextButton(
      child: Text("OK"),
      onPressed: () { 
        Navigator.of(context).pop();
        Navigator.of(context).pop();
        Navigator.of(context).pop();
        Navigator.of(context).pop();
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => ShopReviewScreen(shop, shop.url, prefs)));
      },
    );
    AlertDialog alert = AlertDialog(
      title: Text("Publicación de reseña exitosa", style: TextStyle(color: Color(0xFF0CC665)),),
      content: Text("Su reseña se ha publicado de forma correcta."),
      actions: [
        okButton,
      ],
    );
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}