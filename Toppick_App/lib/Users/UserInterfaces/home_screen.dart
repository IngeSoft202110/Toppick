import 'package:Toppick_App/Users/UserInterfaces/home_card_list.dart';
import 'package:flutter/material.dart';
import '../../GeneralUserInterfaces/gradiant.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [Gradiant(), HomeCardList()],
    );
  }
}