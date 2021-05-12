import 'package:Toppick_App/Orders/Models/pedido.dart';
import 'package:Toppick_App/Users/UserInterfaces/home_card_list.dart';
import 'package:flutter/material.dart';
import '../../GeneralUserInterfaces/gradiant.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen(this.current);
  final Pedido current;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
          body: Stack(
        children: [Gradiant(), HomeCardList(current)],
      ),
    );
  }
}