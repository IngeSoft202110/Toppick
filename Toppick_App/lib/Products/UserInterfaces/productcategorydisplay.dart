import 'package:flutter/material.dart';

class ProductCategoryDisplay extends StatelessWidget {
  ProductCategoryDisplay(this.categoryName, this.categoryDescription, this.products);
  final String categoryName;
  final String categoryDescription;
  final ListView products;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(left: 10.0, bottom: 10.0),
          child: Container(
            alignment: Alignment.centerLeft,
            child: Text(this.categoryName, style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white, fontSize: 25),),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 10.0, bottom: 10.0),
          child: Container(
            alignment: Alignment.centerLeft,
            child: Text(this.categoryDescription, style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white, fontSize: 15),),
          ),
        ),
        SizedBox(
          height: 175,
          child: this.products,
        ),
      ],
    );
  }
}