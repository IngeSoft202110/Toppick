import 'package:Toppick_App/UserInterfaces/shopcategorylist.dart';
import 'package:flutter/material.dart';

class ShopCard extends StatelessWidget {
  ShopCard(this.shop, this.categoryImagePath);
  final Tienda shop;
  final String categoryImagePath;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 185,
      child: Card(
        color: Colors.white,
        shadowColor: Colors.white24,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top:5.0, bottom: 5.0, right: 5.0, left: 10.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Text(this.shop.name, style: TextStyle(fontWeight: FontWeight.bold),),
                  Center(
                    child: Image.asset(
                      'assets/img/foodBox.png', //Aca iria el path de la categoria de la tienda
                      height: 100,
                    ),
                  ),
                  Text("Horario"),
                  Text(this.shop.schedule, style: TextStyle(fontSize: 10),),
                  //Spacer(),
                ]
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Text("Descripcion", style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),),
                    Spacer(),
                    Padding(
                      padding: const EdgeInsets.only(top:10.0, bottom: 5.0),
                      child: Text(this.shop.description),
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