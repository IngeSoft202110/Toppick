import 'package:Toppick_App/Orders/Models/pedido.dart';
import 'package:Toppick_App/Shops/Models/tienda.dart';
import 'package:Toppick_App/Shops/UserInterfaces/home_shop.dart';
import 'package:Toppick_App/GeneralUserInterfaces/gradiant.dart';
import 'package:Toppick_App/GeneralUserInterfaces/header.dart';
import 'package:Toppick_App/GeneralUserInterfaces/search_bar_button.dart';
import 'package:Toppick_App/Shops/UserInterfaces/shopcard.dart';
import 'package:flutter/material.dart';

class ShopList extends StatelessWidget {
  ShopList(this.category, this.categoryImagePath, this.stores, this.current, this.prefs);
  final String category;
  final String categoryImagePath;
  final List<Tienda> stores;
  final Pedido current;
  final prefs;

  List<Widget> buildShopCards(BuildContext context){
    List<Widget> result = [];
    for(int i = 0; i < this.stores.length; i++){
      result.add(Padding(
          padding: const EdgeInsets.only(left:5.0, right: 5.0, bottom: 5.0),
          child: GestureDetector(
            onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context)=> HomeShop(this.stores[i], this.current, this.prefs))),
            child: ShopCard(this.stores[i], this.categoryImagePath)
          ),
        )
      );
    }
    return result;
  }

  @override
  Widget build(BuildContext context) {
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
                Header(this.current, this.prefs),
                SearchButton("Buscar puntos de venta", 2, this.prefs, this.current),
                Padding(
                  padding: const EdgeInsets.only(top:10.0, left:10.0),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(this.category, style: TextStyle(color: Colors.white, fontSize: 35, fontWeight: FontWeight.bold)),
                  ),
                ),
                Column(
                  children: buildShopCards(context),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}