import 'package:flutter/material.dart';

Widget infoHomeCard(String path, String description, double w, double h) {
  return Row(
    children: [
      image(path, w, h),
      Container(
        margin: EdgeInsets.only(top: 7.0),
        width: 200,
        child: Text(
          description,
          style: TextStyle(
              color: Color(0xFF9C9C9C),
              fontWeight: FontWeight.w400,
              fontSize: 20),
        ),
      )
    ],
  );
}
//h 93 w 91

Widget image(String pathImage, double w, double h) {
  return Container(
    height: h,
    width: w,
    margin: EdgeInsets.only(top: 10.0, left: 20.0, right: 45.0),
    decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        image:
            DecorationImage(fit: BoxFit.cover, image: AssetImage(pathImage))),
  );
}

// ignore: must_be_immutable
class HomeCard extends StatelessWidget {
  String path, description, title;
  double w, h;
  var f;
  HomeCard(this.title, this.path, this.description, this.w, this.h, this.f);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(boxShadow: [
        BoxShadow(
            color: Colors.black38, blurRadius: 15.0, offset: Offset(0.0, 7.0))
      ]),
      margin: EdgeInsets.only(top: 30.0, left: 20.0, right: 20.0),
      child: Center(
        child: InkWell(
          onTap: f,
          child: Container(
            height: 200.0,
            width: 405.0,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15.0),
                color: Color(0xFFFFFEEE)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: EdgeInsets.only(top: 10.0, left: 12.0),
                  child: Text(
                    this.title,
                    style: TextStyle(
                        fontSize: 30.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  ),
                ),
                infoHomeCard(this.path, this.description, this.w, this.h)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
