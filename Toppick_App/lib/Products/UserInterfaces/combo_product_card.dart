import 'package:flutter/material.dart';

import '../../GeneralUserInterfaces/generic_button.dart';
import '../Models/producto.dart';

Widget image(String pathImage, double w, double h) {
  return Container(
    height: h,
    width: w,
    decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.circular(30.0),
        image:
            DecorationImage(fit: BoxFit.cover, image: AssetImage(pathImage))),
  );
}

Widget productTitle(String title) {
  return Container(
    child: Text(
      title,
      style: TextStyle(
          fontWeight: FontWeight.w700, fontSize: 25, color: Color(0xFFD76060)),
    ),
  );
}

class ComboProductCard extends StatelessWidget {
  ComboProductCard(this.selected);
  final Producto selected;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 10, left: 30.0, bottom: 15.0),
      width: 180,
      height: 100,
      decoration: BoxDecoration(
          color: Color(0xFFFFFEEE),
          borderRadius: BorderRadius.circular(30.0),
          boxShadow: [
            BoxShadow(
                color: Colors.black38,
                blurRadius: 15.0,
                offset: Offset(0.0, 7.0))
          ]),
      child: Column(
        children: [
          image("assets/img/pescadito.jpg", double.infinity, 120),
          productTitle(this.selected.name),
          (this.selected.category == "A la carta")
              ? GenericButton("personalizar", Color(0xFF0CC665), 115, 20, 10, 0,
                  5, 0, 18, 20, () {/*modal*/})
              : GenericButton("personalizar", Color(0xFF9C9C9C), 115, 20, 10, 0,
                  5, 0, 18, 20, () {/*nada deshabilitado*/}),
        ],
      ),
    );
  }
}
