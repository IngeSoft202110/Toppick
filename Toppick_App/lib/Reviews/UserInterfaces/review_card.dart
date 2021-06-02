import 'package:Toppick_App/Reviews/Models/rewiew.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class ReviewCard extends StatelessWidget {
  ReviewCard(this.review);
  final Resena review;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 150,
      child: Card(
        color: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
        child: Row(
          children: <Widget>[
            Container(
              padding: const EdgeInsets.only(left: 15.0, right: 15.0, top: 10.0),
              child: Column(
                children: <Widget>[
                  Text(this.review.nombreAutor, style: TextStyle(fontWeight: FontWeight.bold),),
                  Icon(Icons.person, size: 75,),
                  RatingBar.builder(
                    initialRating: this.review.calificacion.toDouble(),
                    direction: Axis.horizontal,
                    allowHalfRating: false,
                    itemCount: 5,
                    ignoreGestures: true,
                    itemSize: 20,
                    itemBuilder: (context,_) =>Icon(Icons.star, color: Colors.amber,),
                    onRatingUpdate: (rating)=>{}
                  )
                ],
              ),
            ),
            Expanded(
              child: Container(
                padding: const EdgeInsets.only(left: 15.0, right: 15.0, top: 10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text("Comentario", style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xFFD76060),)),
                    Text(this.review.descripcion, style: TextStyle(color: Color(0xFF707070)),)
                  ],
                ),
              ),
            )
          ],
        )
      ),
    );
  }
}