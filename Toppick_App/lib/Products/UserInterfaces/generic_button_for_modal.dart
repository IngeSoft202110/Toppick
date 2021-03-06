import 'package:flutter/material.dart';

// ignore: must_be_immutable
class GenericButton1 extends StatelessWidget {
  GenericButton1(
      this.buttonText,
      this.buttonColor,
      this.width,
      this.height,
      this.top,
      this.rigth,
      this.bottom,
      this.left,
      this.fontsize,
      this.radius,
      this.transition);
  final String buttonText;
  final Color buttonColor;
  final double width, height, top, left, rigth, bottom, fontsize, radius;
  var transition;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
          top: this.top,
          right: this.rigth,
          bottom: this.bottom,
          left: this.left),
      child: GestureDetector(
        onTap: transition,
        child: Container(
          height: this.height,
          width: this.width,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(radius),
              color: this.buttonColor),
          child: Center(
            child: Text(
              buttonText,
              style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: this.fontsize,
                  color: Color(0xFFFFFEEE)),
            ),
          ),
        ),
      ),
    );
  }
}

class GenericButton2 extends StatelessWidget {
  GenericButton2(this.buttonText, this.buttonColor, this.width, this.height,
      this.top, this.rigth, this.bottom, this.left, this.fontsize, this.radius);
  final String buttonText;
  final Color buttonColor;
  final double width, height, top, left, rigth, bottom, fontsize, radius;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
          top: this.top,
          right: this.rigth,
          bottom: this.bottom,
          left: this.left),
      child: Container(
        height: this.height,
        width: this.width,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(radius),
            color: this.buttonColor),
        child: Center(
          child: Text(
            buttonText,
            style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: this.fontsize,
                color: Color(0xFFFFFEEE)),
          ),
        ),
      ),
    );
  }
}
