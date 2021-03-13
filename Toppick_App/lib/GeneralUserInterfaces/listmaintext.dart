import 'package:flutter/material.dart';

class ListMainText extends StatelessWidget {
  ListMainText(this.firstText, this.secondText);
  final String firstText;
  final String secondText;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(left: 10.0),
          child: Container(alignment: Alignment.centerLeft, child: Text(this.firstText, style: TextStyle(color: Colors.white, fontSize: 35),)),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 10.0),
          child: Container(alignment: Alignment.centerLeft, child: Text(this.secondText, style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white, fontSize: 35),)),
        ),
      ],
    );
  }
}