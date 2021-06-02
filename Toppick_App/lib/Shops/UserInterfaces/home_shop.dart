import 'package:Toppick_App/GeneralUserInterfaces/search_bar_button.dart';
import 'package:Toppick_App/Orders/Models/pedido.dart';
import 'package:Toppick_App/Shops/Models/tienda.dart';
import 'package:Toppick_App/GeneralUserInterfaces/header.dart';
import 'package:flutter/material.dart';
import '../../GeneralUserInterfaces/gradiant.dart';
import '../../UserInterfaces/../Shops/UserInterfaces/home_shop_card.dart';

class HomeShop extends StatelessWidget {
  HomeShop(this.selectedShop, this.current, this.prefs);
  final Pedido current;
  final Tienda selectedShop;
  final prefs;
  @override
  Widget build(BuildContext context) {
    final fusionBody = Container(
      height: MediaQuery.of(context).size.height,
        child: ListView(
          children: <Widget>[
            Header(this.current, this.prefs),
            SearchButton("Buscar tienda", 2, this.prefs, this.current), HomeShopCard(this.selectedShop, this.current, this.prefs),
            SizedBox(height: 10,)
          ],
      )
    );

    return Scaffold(
      body: Stack(
        children: [Gradiant(), fusionBody],
      ),
    );
  }
}
