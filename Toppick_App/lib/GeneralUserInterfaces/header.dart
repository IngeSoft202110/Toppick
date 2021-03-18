import 'package:Toppick_App/Orders/Models/pedido.dart';
import 'package:Toppick_App/Orders/UserInterfaces/ordercard.dart';
import 'package:Toppick_App/Products/Models/producto.dart';
import 'package:Toppick_App/Shops/Models/tienda.dart';
import 'package:flutter/material.dart';

Pedido actual = new Pedido(1, DateTime.now(), 10000, 40, "");
//tiendas para el widget de producto propio
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
    2,
    "Tepanyaki",
    "Cafeterias",
    "L-V: 6:00 A.M - 9:00 P.M \n S: 8:00 am a 4:00pm",
    "En el restaurante La Central brindamos gran variedad de productos: desayunos, almuerzos, comidas rapidas, pizzas, opciones para llevar y un espacio comodo, una experiencia unica ",
    "assets/img/central.PNG",
    true,
    "https://www.google.com/maps/dir//la+central+javeriana/data=!4m6!4m5!1m1!4e2!1m2!1m1!1s0x8e3f9b5f5fdde08f:0x19a674df1df81bae?sa=X&ved=2ahUKEwiBnN-jyKnvAhVju1kKHewoCP4Q9RcwAHoECAQQAw",
  )
];
List<Producto> first = [Producto(
      1,
      "Pescadito",
      3000,
      "NINFO",
      "Hojaldre relleno de arequipe, preparado por los mejores cocineros de toda la universidad.",
      20,
      4.5,
      "Horneados"),];

List<Producto> second =[Producto(
      2,
      "Mani",
      3000,
      "NINFO",
      "Hojaldre relleno de arequipe, preparado por los mejores cocineros de toda la universidad.",
      20,
      4.5,
      "Empaquetados"),Producto(
      2,
      "te",
      4000,
      "NINFO",
      "Hojaldre relleno de arequipe, preparado por los mejores cocineros de toda la universidad.",
      20,
      4.5,
      "Bebida"),];
Map<Tienda, List<Producto>> content = {storeList[0]: first, storeList[1]: second};


class Header extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    actual.carrito = content;
    var f1 = () => Navigator.push(context, MaterialPageRoute(builder: (context) => OrderCard(actual)));
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.only(left: 3.0, right: 3.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Icon(
              Icons.menu,
              color: Colors.white,
              size: 50,
            ),
            Image.asset(
              'assets/img/logo.png',
              height: 85,
            ),
            GestureDetector(
              onTap: (){(actual.carrito.isNotEmpty)?f1():print("no se puede");},
              child: Icon(
                Icons.shopping_bag_outlined,
                color: Colors.white,
                size: 50,
              ),
            )
          ],
        ),
      ),
    );
  }
}
