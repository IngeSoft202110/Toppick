import 'package:Toppick_App/Products/Models/producto.dart';
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

class ProductCard extends StatelessWidget {
  ProductCard(this.product);
  final Producto product;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150,
      child: Card(
        color: Color(0xFFFFFEEE),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
        child: Column(
          children: <Widget>[
            image("assets/img/foodBox.png", 75, 75), //Aqui debe ir la URL del producto
            Text(this.product.name, style: TextStyle(color: Colors.red)),
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
            Text('\$${this.product.price}', style: TextStyle(fontWeight: FontWeight.bold),)
          ],
        ),
      ),
    );
  }
}