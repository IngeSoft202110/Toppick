import 'package:Toppick_App/Models/tienda.dart';
import 'package:Toppick_App/Repositories/quemado.dart';
import 'package:flutter/material.dart';
import 'gradiant.dart';
import 'product_card.dart';
import 'search_bar_button.dart';

// ignore: must_be_immutable
class HomeProduct extends StatelessWidget {
  Tienda a = new Quemado().x;
  @override
  Widget build(BuildContext context) {
    final fusionBody = Column(
      children: [SearchButton("Buscar Tiendas", 2), ProductCard(a)],
    );

    return Stack(
      children: [Gradiant(), fusionBody],
    );
  }
}
