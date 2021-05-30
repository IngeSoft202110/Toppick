import 'package:Toppick_App/Orders/Models/pedido.dart';
import 'package:Toppick_App/Products/Bloc/product_controller.dart';
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
    margin: EdgeInsets.only(bottom: 15.0, left: 15.0, right: 15.0),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          width: 175,
          child: Text(
            title,
            style: TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 30,
                color: Color(0xFFB7B7B7)),
            overflow: TextOverflow.ellipsis,
          ),
        ),
        Text(
          status,
          style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 20,
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
    margin: EdgeInsets.only(bottom: 15.0, left: 15.0, right: 15.0),
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
    margin: EdgeInsets.only(left: 15.0, bottom: 5.0, right: 15.0),
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
  HomeShopCard(this.selected, this.current, this.prefs);
  final Tienda selected;
  final Pedido current;
  final ShopController controller = ShopController();
  final ProductController pController = ProductController();
  final prefs;
  @override
  Widget build(BuildContext context) {
    var transition = (){
      List<dynamic> products = [];
      this.pController.showLoader(context);
      pController.getProductCatalogueById(this.selected.id, prefs.getString('cookie')).then((value) {
        Navigator.of(context).pop();
        products = value;
        Navigator.push(context, MaterialPageRoute(builder: (context) => ProductList(this.current, this.selected, products, this.prefs)));
      });
    };
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
            future: controller.getShopScheduleView(selected.id, this.prefs.getString('cookie')),
            builder: (context,  AsyncSnapshot<List<Horario>> snapshot){
              switch(snapshot.connectionState){
                case ConnectionState.none:
                  break;
                case ConnectionState.waiting:
                  break;
                case ConnectionState.active:
                  break;
                case ConnectionState.done:
                  if(snapshot.hasData){
                    this.selected.schedule = snapshot.data!;
                    return cardSchedule(this.selected.toStringSchedule());
                  }else{
                    return Padding(
                      padding: EdgeInsets.only(bottom: 10.0),
                      child: Center(
                        child: Text(
                          "No se encontraron los horarios", 
                          style: TextStyle(color: Color(0xFFFF441F), fontWeight: FontWeight.bold),
                        )
                      ),
                    );
                  }
              }
              return Container(
                padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
                height: 50,
                child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Colors.red),)
              );
            }
          ),
          GenericButton("Ver Catálogo", Color(0xFF0CC665), 233.0, 45.0, 5.0,
              10.0, 10.0, 10.0, 20.0, 20.0, transition),
          GenericButton("Ver Reseñas", Color(0xFF2196F3), 233.0, 45.0, 5.0,
              10.0, 10.0, 10.0, 20.0, 20.0, transition),
        ],
      ),
    );
  }
}
