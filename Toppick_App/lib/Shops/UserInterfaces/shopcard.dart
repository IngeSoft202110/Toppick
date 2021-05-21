import 'package:Toppick_App/Shops/Models/tienda.dart';
import 'package:flutter/material.dart';

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

class ShopCard extends StatelessWidget {
  ShopCard(this.shop, this.categoryImagePath);
  final Tienda shop;
  final String categoryImagePath;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 185,
      child: Card(
        color: Color(0xFFFFFEEE),
        shadowColor: Colors.white24,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top:5.0, bottom: 5.0, right: 5.0, left: 10.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Text(this.shop.name, style: TextStyle(fontWeight: FontWeight.bold),),
                  SizedBox(height: 25.0),
                  image(this.categoryImagePath, 100, 80),
                ]
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Text("Descripción", style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),),
                    Spacer(),
                    Container(
                      padding: const EdgeInsets.only(top:10.0, bottom: 5.0),
                      child: Text(this.shop.description, style: TextStyle(fontSize: 12),),
                    ),
                    Spacer(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.star, color: Colors.amber,),
                        Icon(Icons.star, color: Colors.amber,),
                        Icon(Icons.star, color: Colors.amber,),
                        Icon(Icons.star, color: Colors.amber,),
                        Icon(Icons.star),
                      ],
                    ),
                  ]
                ),
              ),
            ),
          ]
        ),
      ),
    );
  }
}