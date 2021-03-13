import 'package:Toppick_App/Shops/Models/tienda.dart';
import 'package:Toppick_App/GeneralUserInterfaces/header.dart';
import 'package:flutter/material.dart';
import '../../GeneralUserInterfaces/gradiant.dart';
import '../../UserInterfaces/../Shops/UserInterfaces/home_shop_card.dart';

class HomeShop extends StatelessWidget {
  HomeShop(this.selectedShop);
  final Tienda selectedShop;
  @override
  Widget build(BuildContext context) {
    final fusionBody = Column(
      children: [Header(), HomeShopCard(this.selectedShop)],
    );

    return Scaffold(
      body: Stack(
        children: [Gradiant(), fusionBody],
      ),
    );
  }
}
