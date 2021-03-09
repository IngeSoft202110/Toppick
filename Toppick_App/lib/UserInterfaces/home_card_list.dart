import 'package:flutter/material.dart';

import 'home_card.dart';

class HomeCardList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 5.0),
      height: 650.0,
      width: double.infinity,
      child: ListView(
        scrollDirection: Axis.vertical,
        children: [
          HomeCard(
              "Restaurante",
              "assets/img/store.png",
              "Aqui podras encontrar todo el catalogo de restaurantes, cafeterias y mas que ofrece la universidad",
              93,
              91),
          HomeCard(
              "Productos",
              "assets/img/foodBox.png",
              "Aqui podras encontrar todo el catalogo de productos que ofrece la universidad",
              100,
              136),
          HomeCard(
              "Combos",
              "assets/img/foodBox.png",
              "Aqui podras encontrar todo el catalogo de combos que ofrece la universidad",
              100,
              136),
        ],
      ),
    );
  }
}
