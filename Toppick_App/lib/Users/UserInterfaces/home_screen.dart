import 'package:Toppick_App/Orders/Models/pedido.dart';
import 'package:Toppick_App/Users/UserInterfaces/home_card_list.dart';
import 'package:flutter/material.dart';
import '../../GeneralUserInterfaces/gradiant.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen(this.current, this.prefs, {this.reset=""});
  final Pedido current;
  final prefs;
  final String reset;
  @override
  Widget build(BuildContext context) {
    if(this.reset == "Si"){
      this.prefs.setInt('cantidades', 0);
    }
    return WillPopScope(
          onWillPop: () async {
            return Navigator.canPop(context);
          },
          child: Scaffold(
            body: Stack(
          children: [Gradiant(), HomeCardList(this.current, this.prefs)],
        ),
      ),
    );
  }
}