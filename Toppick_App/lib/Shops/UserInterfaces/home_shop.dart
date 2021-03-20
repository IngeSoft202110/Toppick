import 'package:Toppick_App/GeneralUserInterfaces/search_bar_button.dart';
import 'package:Toppick_App/Orders/Models/pedido.dart';
import 'package:Toppick_App/Shops/Models/tienda.dart';
import 'package:Toppick_App/GeneralUserInterfaces/header.dart';
import 'package:flutter/material.dart';
import '../../GeneralUserInterfaces/gradiant.dart';
import '../../UserInterfaces/../Shops/UserInterfaces/home_shop_card.dart';

class HomeShop extends StatelessWidget {
  HomeShop(this.selectedShop, this.current);
  final Pedido current;
  final Tienda selectedShop;
  @override
  Widget build(BuildContext context) {
    final fusionBody = Container(
        child: ListView(children: <Widget>[Header(this.current), SearchButton("Buscar tienda", 2), HomeShopCard(this.selectedShop, this.current)],
      )
    );

    return Scaffold(
      body: Stack(
        children: [Gradiant(), fusionBody],
      ),
    );
  }
}
