import 'package:flutter/material.dart';

class ShopCategoryCard extends StatelessWidget {
  ShopCategoryCard(this.categoryName, this.categoryDescription, this.categoryLogoPath);
  final String categoryName;
  final String categoryDescription;
  final String categoryLogoPath;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      child: Card(
        color: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
        child: Row(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(left: 10.0, top: 15.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Text(this.categoryName, style: TextStyle(fontWeight: FontWeight.bold)),
                  Image.asset('assets/img/foodBox.png', height:100,), //Colocar con el path de la categoria
                ],
              ),
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(top: 15.0),
                    child: Text("Descripcion", style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold)),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10.0, right: 5.0),
                    child: Text(this.categoryDescription),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}