import 'package:Toppick_App/GeneralUserInterfaces/header.dart';
import 'package:Toppick_App/GeneralUserInterfaces/search_bar_button.dart';
import 'package:Toppick_App/Orders/Models/pedido.dart';
import 'package:Toppick_App/Products/Bloc/product_controller.dart';
import 'package:Toppick_App/Products/UserInterfaces/productlist.dart';
import 'package:Toppick_App/Shops/Models/tienda.dart';
import 'package:Toppick_App/Shops/UserInterfaces/shopcategorylist.dart';
import 'package:flutter/material.dart';

import '../../UserInterfaces/../Users/UserInterfaces/home_card.dart';

// ignore: must_be_immutable
class HomeCardList extends StatelessWidget {
  HomeCardList(this.current, this.prefs);
  final Pedido current;
  final prefs;
  final ProductController controller = ProductController();
  List<dynamic> result = [];
  final hKey = GlobalKey<HeaderState>(debugLabel: "KEY EN HOME");
  @override
  Widget build(BuildContext context) {
    var f1 = () => Navigator.push(
        context, MaterialPageRoute(builder: (context) => ShopCategoryList(this.current, this.prefs)));
    var f2 = () { 
      controller.showLoader(context);
      controller.getAllAvailableProducts(prefs.getString('cookie')).then((value) {
        Navigator.of(context).pop();
        result = value;
        Navigator.push(
        context, MaterialPageRoute(builder: (context) => ProductList(this.current, new Tienda(-1, "", "", "", "", "Cerrado", "",0), this.result, this.prefs)));
      });
    };
    return Container(
      margin: EdgeInsets.only(top: 5.0),
      height: MediaQuery.of(context).size.height,
      width: double.infinity,
      child: ListView(
        scrollDirection: Axis.vertical,
        children: [
          Header(this.current, this.prefs, hKey: this.hKey),
          SearchButton("Buscar Puntos de venta/Productos", 1, this.prefs, this.current, hKey: this.hKey,),
          HomeCard(
              "Puntos de venta",
              "assets/img/store.png",
              "Aquí podrás encontrar todo el catálogo de restaurantes, cafeterías y más que ofrece la universidad.",
              93,
              91,
              f1),
          HomeCard(
              "Productos",
              "assets/img/foodBox.png",
              "Aquí podrás encontrar todo el catálogo de productos que ofrece la universidad.",
              100,
              136,
              f2),
          SizedBox(
            height: 20,
          )
        ],
      ),
    );
  }
}