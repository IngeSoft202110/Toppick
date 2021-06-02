import 'package:Toppick_App/Products/UserInterfaces/personalize.dart';
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
            DecorationImage(fit: BoxFit.cover, image: NetworkImage(pathImage))),
  );
}

Widget productTitle(String title) {
  return Container(
    margin: const EdgeInsets.only(left: 5.0, right: 5.0),
    child: Text(
      title,
      style: TextStyle(
          fontWeight: FontWeight.w700, fontSize: 25, color: Color(0xFFD76060)),
      overflow: TextOverflow.ellipsis,
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
      decoration: BoxDecoration(
          color: Color(0xFFFFFEEE),
          borderRadius: BorderRadius.circular(30.0),
          boxShadow: [
            BoxShadow(
                color: Colors.black38,
                blurRadius: 5.0,
                offset: Offset(0.0, 7.0))
          ]),
      child: Column(
        children: [
          image(this.selected.ulrImage, double.infinity, 120),
          productTitle(this.selected.name),
          (this.selected.category == "A la carta")
              ? AddTodoButton(this.selected)
              : GenericButton("Personalizar", Color(0xFF9C9C9C), 115, 25, 10, 0,
                  5, 0, 18, 20, () {/*nada deshabilitado*/}),
        ],
      ),
    );
  }
}
