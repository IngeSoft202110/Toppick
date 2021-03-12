import 'package:flutter/material.dart';

class BackButtonArrow extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10.0, bottom: 5.0),
      child: Container(alignment: Alignment.centerLeft, child: Icon(Icons.arrow_back, color: Colors.white)),
    );
  }
}