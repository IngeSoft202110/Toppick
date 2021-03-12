import 'package:Toppick_App/UserInterfaces/productlist.dart';
import 'package:flutter/material.dart';

class ProductCard extends StatelessWidget {
  ProductCard(this.product);
  final Producto product;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150,
      child: Card(
        color: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
        child: Column(
          children: <Widget>[
            Image.asset("assets/img/foodBox.png",height:75),
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