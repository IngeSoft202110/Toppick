import 'package:Toppick_App/Products/Models/producto.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

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
  ProductCard(this.product, this.categoryLogoPath);
  final Producto product;
  final String categoryLogoPath;
  @override
  Widget build(BuildContext context) {
    var formatter = NumberFormat('#,###,000');
    String price = (this.product.price==0)?"0":formatter.format(this.product.price);
    return Container(
      width: 200,
      child: Card(
        color: Color(0xFFFFFEEE),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            image(this.categoryLogoPath, 100, 100), //Aqui debe ir la URL del producto
            Padding(
              padding: const EdgeInsets.only(left: 10.0, right: 10.0),    
                child: Text(this.product.name, style: TextStyle(color: Colors.red)),
            ),
            Text('\$$price', style: TextStyle(fontWeight: FontWeight.bold),),
          ],
        ),
      ),
    );
  }
}