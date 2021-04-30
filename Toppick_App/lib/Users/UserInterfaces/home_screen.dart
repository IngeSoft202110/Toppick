import 'package:Toppick_App/Orders/Models/pedido.dart';
import 'package:Toppick_App/Users/UserInterfaces/home_card_list.dart';
import 'package:flutter/material.dart';
import '../../GeneralUserInterfaces/gradiant.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen();
  final Pedido current = Pedido(0, DateTime.now(), 0, DateTime.now(), "Solicitado");
  @override
  Widget build(BuildContext context) {
    return Scaffold(
          body: Stack(
        children: [Gradiant(), HomeCardList(current)],
      ),
    );
  }
}