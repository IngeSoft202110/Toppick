import 'package:Toppick_App/Models/tienda.dart';
import 'package:flutter/material.dart';

import 'generic_button.dart';

Widget image(String pathImage, double w, double h) {
  return Container(
    height: h,
    width: w,
    margin: EdgeInsets.only(bottom: 15.0),
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        shape: BoxShape.rectangle,
        image:
            DecorationImage(fit: BoxFit.cover, image: AssetImage(pathImage))),
  );
}

Widget cardHeader(String title, bool status, String ubication) {
  return Container(
    margin: EdgeInsets.only(bottom: 15.0),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Text(
          title,
          style: TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: 38,
              color: Color(0xFFB7B7B7)),
        ),
        Text(
          (status) ? "Disponible" : "No disponible",
          style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 15,
              color: (status) ? Color(0xFF0CC665) : Color(0xFFD76060)),
        ),
        Icon(
          Icons.place,
          size: 30,
        )
      ],
    ),
  );
}

Widget cardDescription(String description) {
  return Container(
    margin: EdgeInsets.only(bottom: 15.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.only(bottom: 10.0),
          child: Text(
            "Description",
            style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 25,
                color: Color(0xFFD76060)),
          ),
        ),
        Container(
          width: 356,
          height: 55,
          child: Text(
            description,
            style: TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 15,
                color: Color(0xFF707070)),
          ),
        ),
      ],
    ),
  );
}

Widget cardSchedule(String schedule) {
  return Container(
    alignment: Alignment.centerLeft,
    margin: EdgeInsets.only(left: 20.0, bottom: 20.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.only(bottom: 10.0),
          child: Text(
            "Horario",
            style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 25,
                color: Color(0xFFD76060)),
          ),
        ),
        Container(
          width: 128,
          height: 28,
          alignment: Alignment.centerLeft,
          child: Text(
            schedule,
            style: TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 12,
                color: Color(0xFF707070)),
          ),
        ),
      ],
    ),
  );
}

class ProductCard extends StatelessWidget {
  ProductCard(this.selected);
  final Tienda selected;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 18.0),
      width: 392,
      height: 582,
      decoration: BoxDecoration(
        color: Color(0xFFFFFEEE),
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Column(
        children: [
          image(this.selected.url, 392, 201),
          cardHeader(this.selected.name, this.selected.status,
              this.selected.ubication),
          cardDescription(this.selected.description),
          cardSchedule(this.selected.schedule),
          GenericButton("Ver Catalogo", Color(0xFF0CC665), 233.0, 55.0, 10.0,
              10.0, 10.0, 10.0, 30.0, 20.0)
        ],
      ),
    );
  }
}
