import 'package:Toppick_App/GeneralUserInterfaces/generic_button.dart';
import 'package:Toppick_App/Reviews/Bloc/rewiew_controller.dart';
import 'package:Toppick_App/Reviews/Models/rewiew.dart';
import 'package:Toppick_App/Reviews/UserInterfaces/create_shop_review_screen.dart';
import 'package:Toppick_App/Reviews/UserInterfaces/review_card.dart';
import 'package:Toppick_App/Shops/Models/tienda.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

// ignore: must_be_immutable
class ShopReviewScreen extends StatelessWidget {
  ShopReviewScreen(this.shop, this.imagePath, this.prefs);
  final Tienda shop;
  final String imagePath;
  List<Resena> reviews = [];
  final ReviewController controller = ReviewController();
  final prefs;

  Widget image(String pathImage, double w, double h) {
    return Container(
      height: h,
      width: w,
      decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          
          image:
              DecorationImage(fit: BoxFit.cover, image: AssetImage(pathImage))),
    );
  }

  @override
  Widget build(BuildContext context) {
    this.reviews = [];
    var createReview=(){
      Navigator.push(context, MaterialPageRoute(builder: (context) => CreateShopReviewScreen(this.prefs, this.shop)));
    };
    return Scaffold(
      body: Stack(
        clipBehavior: Clip.none,
        children: <Widget>[
          Container(
            child: image(this.imagePath, double.infinity, MediaQuery.of(context).size.height*0.30),
          ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height*0.75,
                decoration: BoxDecoration(borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20)), color: Color(0xFFFFFEEE),),
                padding: const EdgeInsets.only(left:10.0, right: 10.0,),
                child: ListView(
                  children: <Widget>[
                    Center(
                      child: Text(this.shop.name, style: TextStyle(color: Color(0xFFD76060), fontSize: 40, fontWeight: FontWeight.bold))
                    ),
                    Text("Descripción", style: TextStyle(color: Color(0xFFD76060), fontSize: 30, fontWeight: FontWeight.bold)),
                    Container(
                      padding: const EdgeInsets.only(top: 10.0, bottom: 5.0),
                      child: Text(this.shop.description, style: TextStyle(fontWeight: FontWeight.w400,fontSize: 15, color: Color(0xFF707070)),)
                    ),
                    Text("Reseñas", style: TextStyle(color: Color(0xFFD76060), fontSize: 30, fontWeight: FontWeight.bold)),
                    SizedBox(
                      height: 180,
                      child: FutureBuilder(
                        future: this.controller.getShopReviews(this.prefs.getString('cookie'), this.shop.id),
                        builder: (context, AsyncSnapshot<List<Resena>> snapshot){
                          switch (snapshot.connectionState) {
                            case ConnectionState.none:
                              break;
                            case ConnectionState.waiting:
                              break;
                            case ConnectionState.active:
                              break;
                            case ConnectionState.done:
                              if(snapshot.hasData){
                                this.reviews = snapshot.data!;
                                if(this.reviews.isNotEmpty){
                                  return ListView.builder(
                                    itemCount: this.reviews.length,
                                    scrollDirection: Axis.vertical,
                                    physics: ScrollPhysics(),
                                    shrinkWrap: true,
                                    itemBuilder: (BuildContext context, int index) => ReviewCard(this.reviews[index])
                                  );
                                }else{
                                  return Center(
                                    child:Text("No se han encontrado reseñas", style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xFFFF441F), fontSize: 20,))
                                  );
                                }
                              }
                          }
                          return Center(
                            child: Container(
                              padding: const EdgeInsets.all(10),
                              height: 50,
                              child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Colors.red),)
                            ),
                          );
                        }
                      )
                    ),
                    Row(
                      children: <Widget>[
                        Container(
                          padding: const EdgeInsets.only(top: 10.0, left:10.0, right: 10.0),
                          child: Text("Califiación total: ", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: Color(0xFFD76060)),)
                        ),
                        Container(
                          padding: const EdgeInsets.only(top: 10.0, left:10.0, right: 10.0),
                          child: RatingBar.builder(
                            initialRating: this.shop.calificacion,
                            direction: Axis.horizontal,
                            allowHalfRating: true,
                            itemCount: 5,
                            ignoreGestures: true,
                            itemSize: 30,
                            itemBuilder: (context,_) =>Icon(Icons.star, color: Colors.amber,),
                            onRatingUpdate: (rating)=>{}
                          ),
                        )
                      ],
                    ),
                    Center(
                      child: GenericButton("Escribir reseña", Color(0xFF2196F3), 225, 40, 15, 0, 0, 0, 20, 20, createReview)
                    ),
                    Center(
                      child: GenericButton("Volver", Color(0xFFFB2900), 225, 40, 10, 0, 10, 0, 20, 20, ()=>{Navigator.pop(context)})
                    )
                  ]
                ),
              ),
            ),
        ],
      ),
    );
  }
}