import 'package:Toppick_App/UserInterfaces/backarrowbutton.dart';
import 'package:Toppick_App/UserInterfaces/gradiant.dart';
import 'package:Toppick_App/UserInterfaces/header.dart';
import 'package:Toppick_App/UserInterfaces/listmaintext.dart';
import 'package:Toppick_App/UserInterfaces/shopcategorycard.dart';
import 'package:Toppick_App/UserInterfaces/shoplits.dart';
import 'package:flutter/material.dart';

List<String> categories = [
  'Cafeterias',
  'Cafes y Kioskos',
  'Saludable',
  'Restaurantes',
];

List<String> descriptions = [
  'Cafeterias de la universidad',
  'Cafes y Kioscos ubicados en la universidad, los puedes encontrar en muchos lugares',
  'Puntos de venta de comida saludable',
  'Restaurantes de la universidad',
];

List<String> logoPahts = [
  'assets/icons/cafeteria.png',
  'assets/icons/cafesykioskos.png',
  'assets/icons/saludable.png',
  'assets/icons/restaurantes.png',
];

class Tienda{
  String name;
  String category;
  String schedule;
  String description;
  Tienda(this.name, this.category, this.schedule, this.description);
}

List<Tienda> storeList = [
  Tienda(
    "La Central", 
    "Cafeterias", 
    "L-V: 6:00 A.M - 9:00 P.M",
    "En el restaurante La Central brindamos gran variedad de productos: desayunos, almuerzos, comidas rapidas, pizzas, opciones para llevar y un espacio comodo, una experiencia unica "
  ),
  Tienda(
    "La Central", 
    "Cafeterias", 
    "L-V: 6:00 A.M - 9:00 P.M",
    "En el restaurante La Central"
  ),
  Tienda(
    "La Central", 
    "Cafeterias", 
    "L-V: 6:00 A.M - 9:00 P.M",
    "En el restaurante La Central brindamos gran variedad de productos: desayunos, almuerzos, comidas rapidas, pizzas, opciones para llevar y un espacio comodo, una experiencia unica "
  ),
  Tienda(
    "La Central", 
    "Cafeterias", 
    "L-V: 6:00 A.M - 9:00 P.M",
    "En el restaurante La Central brindamos gran variedad de productos: desayunos, almuerzos, comidas rapidas, pizzas, opciones para llevar y un espacio comodo, una experiencia unica "
  ),
  Tienda(
    "El Kiosko",
    "Cafes y Kioskos",
    "L-V: 6:00 A.M - 9:00 P.M",
    "En el Kiosko servimos los mejores platos que puedes encontrar en la universidad.",
  )
];

List<Tienda> filterShops(List<Tienda> shops, String category){
  List<Tienda> filtered = [];
  for(Tienda shop in shops){
    if(shop.category == category)
      filtered.add(shop);
  }
  return filtered;
}

class ShopCategoryList extends StatelessWidget {
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
                padding: const EdgeInsets.only(top: 20.0),
                child: ListMainText("Escoge", "Tu forma de comer"),
              ),
              SizedBox(
                height: 400,
                child:ListView.builder(
                  itemCount: categories.length,
                  itemBuilder: (BuildContext context, int index){
                    return GestureDetector(
                      onTap: (){
                        List<Tienda> filtered = filterShops(storeList, categories[index]);
                        Navigator.push(context, MaterialPageRoute(builder: (context)=> ShopList(categories[index], logoPahts[index], filtered)));
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(left:5.0, right: 5.0, bottom: 5.0),
                        child: ShopCategoryCard(categories[index], descriptions[index], logoPahts[index]),
                      ),
                    );
                  }
                ),
              ),
            ],
          ),  
        ]
      )
    );
  }
}