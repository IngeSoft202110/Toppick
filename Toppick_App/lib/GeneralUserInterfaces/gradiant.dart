import 'package:flutter/material.dart';

class Gradiant extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
          gradient: LinearGradient(begin: Alignment.topCenter, colors: [
        Color(0xFFFD8901),
        Color(0xFFFC8C08),
        Color(0xFFF59C32)
      ])),
    );
  }
}
