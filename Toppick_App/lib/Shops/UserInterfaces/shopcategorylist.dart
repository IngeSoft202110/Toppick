import 'package:Toppick_App/Shops/Models/tienda.dart';
import 'package:Toppick_App/GeneralUserInterfaces/gradiant.dart';
import 'package:Toppick_App/GeneralUserInterfaces/header.dart';
import 'package:Toppick_App/GeneralUserInterfaces/listmaintext.dart';
import 'package:Toppick_App/GeneralUserInterfaces/search_bar_button.dart';
import 'package:Toppick_App/Shops/UserInterfaces/shopcategorycard.dart';
import 'package:Toppick_App/Shops/UserInterfaces/shoplits.dart';
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

List<Tienda> storeList = [
  Tienda(
    1,
    "La Central", 
    "Cafeterias", 
    "L-V: 6:00 A.M - 9:00 P.M \n S: 8:00 am a 4:00pm",
    "En el restaurante La Central brindamos gran variedad de productos: desayunos, almuerzos, comidas rapidas, pizzas, opciones para llevar y un espacio comodo, una experiencia unica ",
    "assets/img/central.PNG",
    true,
    "https://www.google.com/maps/dir//la+central+javeriana/data=!4m6!4m5!1m1!4e2!1m2!1m1!1s0x8e3f9b5f5fdde08f:0x19a674df1df81bae?sa=X&ved=2ahUKEwiBnN-jyKnvAhVju1kKHewoCP4Q9RcwAHoECAQQAw",
  ),
  Tienda(
    1,
    "La Central", 
    "Cafeterias", 
    "L-V: 6:00 A.M - 9:00 P.M \n S: 8:00 am a 4:00pm",
    "En el restaurante La Central brindamos gran variedad de productos: desayunos, almuerzos, comidas rapidas, pizzas, opciones para llevar y un espacio comodo, una experiencia unica ",
    "assets/img/central.PNG",
    true,
    "https://www.google.com/maps/dir//la+central+javeriana/data=!4m6!4m5!1m1!4e2!1m2!1m1!1s0x8e3f9b5f5fdde08f:0x19a674df1df81bae?sa=X&ved=2ahUKEwiBnN-jyKnvAhVju1kKHewoCP4Q9RcwAHoECAQQAw",
  ),
  Tienda(
    1,
    "La Central", 
    "Cafeterias", 
    "L-V: 6:00 A.M - 9:00 P.M \n S: 8:00 am a 4:00pm",
    "En el restaurante La Central brindamos gran variedad de productos: desayunos, almuerzos, comidas rapidas, pizzas, opciones para llevar y un espacio comodo, una experiencia unica ",
    "assets/img/central.PNG",
    true,
    "https://www.google.com/maps/dir//la+central+javeriana/data=!4m6!4m5!1m1!4e2!1m2!1m1!1s0x8e3f9b5f5fdde08f:0x19a674df1df81bae?sa=X&ved=2ahUKEwiBnN-jyKnvAhVju1kKHewoCP4Q9RcwAHoECAQQAw",
  ),
  Tienda(
    1,
    "La Central", 
    "Cafeterias", 
    "L-V: 6:00 A.M - 9:00 P.M \n S: 8:00 am a 4:00pm",
    "En el restaurante La Central brindamos gran variedad de productos: desayunos, almuerzos, comidas rapidas, pizzas, opciones para llevar y un espacio comodo, una experiencia unica ",
    "assets/img/central.PNG",
    true,
    "https://www.google.com/maps/dir//la+central+javeriana/data=!4m6!4m5!1m1!4e2!1m2!1m1!1s0x8e3f9b5f5fdde08f:0x19a674df1df81bae?sa=X&ved=2ahUKEwiBnN-jyKnvAhVju1kKHewoCP4Q9RcwAHoECAQQAw",
  ),
  Tienda(
    1,
    "La Central", 
    "Cafeterias", 
    "L-V: 6:00 A.M - 9:00 P.M \n S: 8:00 am a 4:00pm",
    "En el restaurante La Central brindamos gran variedad de productos: desayunos, almuerzos, comidas rapidas, pizzas, opciones para llevar y un espacio comodo, una experiencia unica ",
    "assets/img/central.PNG",
    true,
    "https://www.google.com/maps/dir//la+central+javeriana/data=!4m6!4m5!1m1!4e2!1m2!1m1!1s0x8e3f9b5f5fdde08f:0x19a674df1df81bae?sa=X&ved=2ahUKEwiBnN-jyKnvAhVju1kKHewoCP4Q9RcwAHoECAQQAw",
  ),
  Tienda(
    1,
    "La Central", 
    "Cafes y Kioskos", 
    "L-V: 6:00 A.M - 9:00 P.M \n S: 8:00 am a 4:00pm",
    "En el restaurante La Central brindamos gran variedad de productos: desayunos, almuerzos, comidas rapidas, pizzas, opciones para llevar y un espacio comodo, una experiencia unica ",
    "assets/img/central.PNG",
    true,
    "https://www.google.com/maps/dir//la+central+javeriana/data=!4m6!4m5!1m1!4e2!1m2!1m1!1s0x8e3f9b5f5fdde08f:0x19a674df1df81bae?sa=X&ved=2ahUKEwiBnN-jyKnvAhVju1kKHewoCP4Q9RcwAHoECAQQAw",
  ),
];

List<Tienda> filterShops(List<Tienda> shops, String category){
  List<Tienda> filtered = [];
  for(Tienda shop in shops){
    if(shop.category == category)
      filtered.add(shop);
  }
  return filtered;
}

List<Widget> buildCategoriesCard(BuildContext context){
  List<Widget> results = [];
  for(int i = 0; i < categories.length; i++){
    results.add(GestureDetector(
      onTap: (){
        List<Tienda> filtered = filterShops(storeList, categories[i]);
        Navigator.push(context, MaterialPageRoute(builder: (context)=> ShopList(categories[i], logoPahts[i], filtered)));
      },
      child: Padding(
        padding: const EdgeInsets.only(left:5.0, right: 5.0, bottom: 5.0),
        child: ShopCategoryCard(categories[i], descriptions[i], logoPahts[i]),
      ),
    ));
  }
  return results;
}
class ShopCategoryList extends StatelessWidget {
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
                Header(),
                SearchButton("Buscar puntos de venta", 2),
                Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                  child: ListMainText("Escoge", "Tu forma de comer"),
                ),
                Column(
                  children: buildCategoriesCard(context),
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