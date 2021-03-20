import 'package:Toppick_App/Orders/Models/pedido.dart';
import 'package:Toppick_App/Shops/Bloc/shop_controller.dart';
import 'package:Toppick_App/Shops/Models/tienda.dart';
import 'package:Toppick_App/GeneralUserInterfaces/gradiant.dart';
import 'package:Toppick_App/GeneralUserInterfaces/header.dart';
import 'package:Toppick_App/GeneralUserInterfaces/listmaintext.dart';
import 'package:Toppick_App/GeneralUserInterfaces/search_bar_button.dart';
import 'package:Toppick_App/Shops/UserInterfaces/shopcategorycard.dart';
import 'package:Toppick_App/Shops/UserInterfaces/shoplits.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class ShopCategoryList extends StatelessWidget {
  ShopCategoryList(this.current);
  final Pedido current;
  final ShopController controller = ShopController();
  List<String> categories = [];
  List<String> descriptions = [];
  List<String> logoPahts = [];
  List<Tienda> shopList = [];

  List<Widget> buildCategoriesCard(BuildContext context, Pedido current){
    List<Widget> results = [];
    for(int i = 0; i < categories.length; i++){
      results.add(GestureDetector(
        onTap: (){
          List<Tienda> filtered = this.controller.filterShops(this.shopList, categories[i]);
          Navigator.push(context, MaterialPageRoute(builder: (context)=> ShopList(categories[i], logoPahts[i], filtered, current)));
        },
        child: Padding(
          padding: const EdgeInsets.only(left:5.0, right: 5.0, bottom: 5.0),
          child: ShopCategoryCard(categories[i], descriptions[i], logoPahts[i]),
        ),
      ));
    }
    return results;
  }

  @override
  Widget build(BuildContext context) {
    this.categories = this.controller.getShopCategories();
    this.descriptions = this.controller.getCategoryDescription();
    this.logoPahts = this.controller.getCategoryImagePath();
    this.shopList = this.controller.getAllAvailableShops();
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Gradiant(),
          Container(
            margin: EdgeInsets.only(top: 5.0),
            height: MediaQuery.of(context).size.height,
            width: double.infinity,
            child: ListView(
              children: <Widget>[
                Header(this.current),
                SearchButton("Buscar puntos de venta", 2),
                Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                  child: ListMainText("Escoge", "Tu forma de comer"),
                ),
                Column(
                  children: buildCategoriesCard(context, this.current),
                ),
                SizedBox(
                  height: 10,
                ),
              ]
            ),
          ),  
        ]
      )
    );
  }
}