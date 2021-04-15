import 'package:Toppick_App/Orders/Models/pedido.dart';
import 'package:Toppick_App/Products/UserInterfaces/productlist.dart';
import 'package:Toppick_App/Shops/Bloc/shop_controller.dart';
import 'package:Toppick_App/Shops/Models/horario.dart';
import 'package:Toppick_App/Shops/Models/tienda.dart';
import 'package:flutter/material.dart';

import '../../GeneralUserInterfaces/generic_button.dart';

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

Widget cardHeader(String title, String status, String ubication) {
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
          status,
          style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 15,
              color: (status=="Abierto") ? Color(0xFF0CC665) : Color(0xFFD76060)),
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
            "Descripción",
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
          width: 200,
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

class HomeShopCard extends StatelessWidget {
  HomeShopCard(this.selected, this.current);
  final Tienda selected;
  final Pedido current;
  final ShopController controller = ShopController();
  @override
  Widget build(BuildContext context) {
    var transition = () => Navigator.push(context, MaterialPageRoute(builder: (context) => ProductList(this.current, this.selected)));
    return Container(
      margin: EdgeInsets.only(top: 18.0, left: 10.0, right: 10.0),
      width: 392,
      decoration: BoxDecoration(
        color: Color(0xFFFFFEEE),
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Column(
        children: [
          image(this.selected.url, double.infinity, 201),
          cardHeader(this.selected.name, this.selected.status,
              this.selected.ubication),
          cardDescription(this.selected.description),
          FutureBuilder(
            future: controller.getShopScheduleView(selected.id),
            builder: (context,  AsyncSnapshot<List<Horario>> snapshot){
              switch(snapshot.connectionState){
                case ConnectionState.none:
                  break;
                case ConnectionState.waiting:
                  break;
                case ConnectionState.active:
                  break;
                case ConnectionState.done:
                this.selected.schedule = snapshot.data!;
                  return cardSchedule(this.selected.toStringSchedule());
              }
              return Container(
                padding: const EdgeInsets.only(top: 150.0, left: 150, right: 150),
                height: 250,
                child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Colors.red),)
              );
            }
          ),
          GenericButton("Ver Catálogo", Color(0xFF0CC665), 233.0, 55.0, 10.0,
              10.0, 10.0, 10.0, 30.0, 20.0, transition)
        ],
      ),
    );
  }
}
