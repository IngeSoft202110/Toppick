import 'package:Toppick_App/UserInterfaces/backarrowbutton.dart';
import 'package:Toppick_App/UserInterfaces/gradiant.dart';
import 'package:Toppick_App/UserInterfaces/header.dart';
import 'package:Toppick_App/UserInterfaces/shopcard.dart';
import 'package:Toppick_App/UserInterfaces/shopcategorylist.dart';
import 'package:flutter/material.dart';

class ShopList extends StatelessWidget {
  ShopList(this.category, this.categoryImagePath, this.stores);
  final String category;
  final String categoryImagePath;
  final List<Tienda> stores;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Gradiant(),
          Column(
            children: <Widget>[
              Header(),
              BackButtonArrow(),
              Padding(
                padding: const EdgeInsets.only(top:10.0, left:10.0),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(this.category, style: TextStyle(color: Colors.white, fontSize: 35, fontWeight: FontWeight.bold)),
                ),
              ),
              SizedBox(
                height: 400,
                child: ListView.builder(
                  itemCount: this.stores.length,
                  itemBuilder: (BuildContext context, int index){
                    return Padding(
                      padding: const EdgeInsets.only(left:5.0, right: 5.0, bottom: 5.0),
                      child: ShopCard(this.stores[index], this.categoryImagePath),
                    );
                  }
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}