import 'package:flutter/material.dart';

class Gradiant extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
          gradient: LinearGradient(begin: Alignment.topCenter, colors: [
        Colors.orange[900],
        Colors.orange[800],
        Colors.orange[400]
      ])),
    );
  }
}
