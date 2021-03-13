import 'package:Toppick_App/GeneralUserInterfaces/header.dart';
import 'package:Toppick_App/Users/UserInterfaces/home_card_list.dart';
import 'package:Toppick_App/GeneralUserInterfaces/search_bar_button.dart';
import 'package:flutter/material.dart';

import '../../GeneralUserInterfaces/gradiant.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final fusionBody = Column(
      children: [Header(), SearchButton("Buscar Tiendas/Productos", 1), HomeCardList()],
    );

    return Stack(
      children: [Gradiant(), fusionBody],
    );
  }
}
