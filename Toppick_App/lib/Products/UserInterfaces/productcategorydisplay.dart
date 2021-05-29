import 'package:Toppick_App/Orders/Models/pedido.dart';
import 'package:Toppick_App/Products/Models/combo.dart';
import 'package:Toppick_App/Products/UserInterfaces/productcard.dart';
import 'package:Toppick_App/Shops/Models/tienda.dart';
import 'package:flutter/material.dart';

import 'home_combos_card.dart';
import 'home_product_card.dart';

class ProductCategoryDisplay extends StatelessWidget {
  ProductCategoryDisplay(this.categoryName, this.categoryDescription, this.products, this.store, this.current, this.prefs, this.hKey);
  final String categoryName;
  final String categoryDescription;
  final List<dynamic> products;
  final Tienda store;
  final Pedido current;
  final prefs;
  final hKey;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(left: 10.0, bottom: 10.0),
          child: Container(
            alignment: Alignment.centerLeft,
            child: Text(this.categoryName, style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white, fontSize: 25),),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 10.0, bottom: 10.0),
          child: Container(
            alignment: Alignment.centerLeft,
            child: Text(this.categoryDescription, style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white, fontSize: 15),),
          ),
        ),
        SizedBox(
          height: 175,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: products.length,
            itemBuilder: (BuildContext context, int index){
              return GestureDetector(
                  onTap: () => {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          if(products[index] is Combo){
                            return HomeCombosCard(products[index], this.store, this.current, this.prefs, this.hKey);
                          }else{
                            return HomeProductCard(products[index], this.store, this.current, this.prefs, this.hKey);
                          }
                        }
                      )
                    )
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(left: 15.0),
                    child: ProductCard(products[index]),
                  ),
                );
            },
          ),
        ),
      ],
    );
  }
}