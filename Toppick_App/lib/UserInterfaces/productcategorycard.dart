import 'package:flutter/material.dart';

class ProductCategoryCard extends StatefulWidget {
  ProductCategoryCard(this.categoryName, this.categoryDescription, this.categoryLogoPath);
  final String categoryName;
  final String categoryDescription;
  final String categoryLogoPath;
  @override
  _ProductCategoryCardState createState() => _ProductCategoryCardState(this.categoryName);
}

class _ProductCategoryCardState extends State<ProductCategoryCard> {
  _ProductCategoryCardState(this.categoryName);
  final String categoryName;
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
            Image.asset("assets/img/foodBox.png",height:100), //Colocar con el path de la categoria
            Text(categoryName, style: TextStyle(fontWeight: FontWeight.bold),),
          ],
        ),
      ),
    );
  }
}