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


class ProductCategoryCard extends StatefulWidget {
  ProductCategoryCard(this.categoryName, this.categoryDescription, this.categoryLogoPath);
  final String categoryName;
  final String categoryDescription;
  final String categoryLogoPath;
  @override
  _ProductCategoryCardState createState() => _ProductCategoryCardState(this.categoryName, this.categoryLogoPath);
}

class _ProductCategoryCardState extends State<ProductCategoryCard> {
  _ProductCategoryCardState(this.categoryName, this.imagePath);
  final String categoryName;
  final String imagePath;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150,
      child: Card(
        color: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            image(this.imagePath, 100, 100),
            Text(categoryName, style: TextStyle(fontWeight: FontWeight.bold),),
          ],
        ),
      ),
    );
  }
}