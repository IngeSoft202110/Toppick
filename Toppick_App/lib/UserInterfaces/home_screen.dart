import 'package:Toppick_App/UserInterfaces/home_card_list.dart';
import 'package:Toppick_App/UserInterfaces/search_bar_button.dart';
import 'package:flutter/material.dart';

import 'gradiant.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final fusionBody = Column(
      children: [SearchButton("Buscar Tiendas/Productos", 1), HomeCardList()],
    );

    return Stack(
      children: [Gradiant(), fusionBody],
    );
  }
}
