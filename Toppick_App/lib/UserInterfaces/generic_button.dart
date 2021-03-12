import 'package:flutter/material.dart';

// ignore: must_be_immutable
class GenericButton extends StatelessWidget {
  String buttonText = "";
  Color buttonColor;
  double width, height, top, left, rigth, bottom, fontsize, radius;
  GenericButton(this.buttonText, this.buttonColor, this.width, this.height,
      this.top, this.rigth, this.bottom, this.left, this.fontsize, this.radius);
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
          top: this.top,
          right: this.rigth,
          bottom: this.bottom,
          left: this.left),
      child: InkWell(
        onTap: () => {},
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
