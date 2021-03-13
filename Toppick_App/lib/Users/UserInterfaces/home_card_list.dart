import 'package:Toppick_App/Products/UserInterfaces/productlist.dart';
import 'package:Toppick_App/Shops/UserInterfaces/shopcategorylist.dart';
import 'package:flutter/material.dart';

import '../../UserInterfaces/../Users/UserInterfaces/home_card.dart';

class HomeCardList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var f1 = () => Navigator.push(context, MaterialPageRoute(builder: (context) => ShopCategoryList()));
    var f2 = () => Navigator.push(context, MaterialPageRoute(builder: (context) => ProductList()));
    var f3 = () => Navigator.push(context, MaterialPageRoute(builder: (context) => ProductList()));
    return Container(
      margin: EdgeInsets.only(top: 5.0),
      height: 480.0,
      width: double.infinity,
      child: ListView(
        scrollDirection: Axis.vertical,
        children: [
          HomeCard(
              "Puntos de venta",
              "assets/img/store.png",
              "Aqui podras encontrar todo el catalogo de restaurantes, cafeterias y mas que ofrece la universidad",
              93,
              91,
              f1),
          HomeCard(
              "Productos",
              "assets/img/foodBox.png",
              "Aqui podras encontrar todo el catalogo de productos que ofrece la universidad",
              100,
              136,
              f2),
          HomeCard(
              "Combos",
              "assets/img/foodBox.png",
              "Aqui podras encontrar todo el catalogo de combos que ofrece la universidad",
              100,
              136,
              f3),
        ],
      ),
    );
  }
}
