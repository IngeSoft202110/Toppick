import 'package:Toppick_App/GeneralUserInterfaces/generic_button.dart';
import 'package:Toppick_App/Reviews/Bloc/rewiew_controller.dart';
import 'package:Toppick_App/Reviews/Models/rewiew.dart';
import 'package:Toppick_App/Shops/Models/tienda.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

// ignore: must_be_immutable
class CreateShopReviewScreen extends StatelessWidget {
  CreateShopReviewScreen(this.prefs, this.shop);
  final prefs;
  final Tienda shop;
  final formKey = GlobalKey<FormState>();
  String opinion = "";
  final ReviewController controller = ReviewController();
  @override
  Widget build(BuildContext context) {
    int calificacion = 5;
    var check = (){
      if (formKey.currentState!.validate()){
        print("valido");
        formKey.currentState!.save();
        Resena resena = Resena(calificacion, this.opinion, "");
        this.controller.showLoader(context);
        this.controller.publishShopReview(this.prefs.getString('cookie'), this.shop.id, resena).then(
          (value){
            if(value){
              this.controller.showCorrectPublishShopReview(context, this.shop, this.prefs);
            }else{
              this.controller.showPublishShopReviewError(context);
            }
          }
        );
      }
    };
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: double.infinity,
        decoration: BoxDecoration(color: Color(0xFFFFFEEE),),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              padding: const EdgeInsets.only(left:10.0, right: 10.0, top: 25.0),
              child: Text("Déjanos tu opinión del punto de venta", style: TextStyle(color: Color(0xFFD76060), fontSize: 40, fontWeight: FontWeight.bold),),
            ),
            Form(
              key: this.formKey,
              child: Container(
                padding: const EdgeInsets.only(left:10.0, right: 10.0, top: 25.0),
                child: TextFormField(
                  maxLength: 100,
                  maxLines: 5,
                  minLines: 3,
                  autocorrect: false,
                  decoration: InputDecoration(
                    alignLabelWithHint: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(20),),
                    labelText: "Tu opinión",
                  ),
                  onSaved: (value) {
                    opinion = value!;
                  },
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Ingrese su opinión";
                    }
                    else if (value.contains(new RegExp(r'[!@#$%^(),.?":{}|<>]'))){
                      return "Sin caracteres especiales";
                    }
                  },
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.only(left:10.0, right: 10.0, top: 17.5, bottom: 10.0),
              child: Text("Calificación", style: TextStyle(color: Color(0xFFD76060), fontSize: 30, fontWeight: FontWeight.bold),),
            ),
            RatingBar.builder(
              initialRating: 5,
              minRating: 1,
              direction: Axis.horizontal,
              allowHalfRating: false,
              itemCount: 5,
              itemPadding: EdgeInsets.symmetric(horizontal: 10.0),
              itemBuilder: (context, _) => Icon(Icons.star, color: Colors.amber,),
              onRatingUpdate: (rating){
                calificacion = rating.toInt();
              }
            ),
            Center(
              child: GenericButton("Enviar reseña", Color(0xFF0CC665), 225, 40, 30, 0, 0, 0, 20, 20, check)
            ),
            Center(
              child: GenericButton("Volver", Color(0xFFFB2900), 225, 40, 10, 0, 10, 0, 20, 20, ()=>{})
            )
          ],
        ),
      )
    );
  }
}