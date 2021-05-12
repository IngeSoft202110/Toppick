import 'package:Toppick_App/Orders/Models/pedido.dart';
import 'package:Toppick_App/Orders/UserInterfaces/order_card.dart';
import 'package:Toppick_App/Products/Models/producto.dart';
import 'package:Toppick_App/Products/UserInterfaces/custom_rect_tween.dart';
import 'package:Toppick_App/Shops/Models/tienda.dart';
import 'package:flutter/material.dart';

import 'menu.dart';

Pedido current2 = Pedido(0, DateTime.now(), 9000, DateTime.now(), "Cocinando");
Map<Tienda?, Map<Producto, int>> solicitados1 = {Tienda(0, "Tepanyaki","","","","Abierto",""):{
  Producto(1, "Pescadito", "descripcion", 3000, 20, 4.5, "URL", "Otros", "Horneado") : 2,
  Producto(2, "Té", "Té frio", 2000, 20, 4.5, "URL", "Bebidas", "Tés"): 1,
  Producto(3, "Maní", "descripcion", 1000, 0, 4.0, "URL", "Empaquetados", "Salados"): 1
}};
Map<Tienda?, Map<Producto, int>> solicitados2 = {Tienda(0, "La central","","","","Abierto",""):{
  Producto(1, "Pescadito", "descripcion", 3000, 20, 4.5, "URL", "Otros", "Horneado") : 2,
  Producto(2, "Té", "Té frio", 2000, 20, 4.5, "URL", "Bebidas", "Tés"): 1,
  Producto(3, "Maní", "descripcion", 1000, 0, 4.0, "URL", "Empaquetados", "Salados"): 1
}};

Pedido current3 = Pedido(0, DateTime.now(), 9000, DateTime.now(), "Listo");

List<Pedido> pedidos = [current2, current3,];

showAlert(BuildContext context){
  Widget okButton = TextButton(
    child: Text("OK"),
    onPressed: () { Navigator.of(context).pop();},
  );
  AlertDialog alert = AlertDialog(
    title: Text("No hay un pedido", style: TextStyle(color: Color(0xFFD76060)),),
    content: Text("Agrega productos a tu pedido para poder acceder a la pantalla de pedido."),
    actions: [
      okButton,
    ],
  );
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}

class Header extends StatelessWidget {
  Header(this.actual);
  final Pedido actual;
  @override
  Widget build(BuildContext context) {
    current2.carrito = solicitados1;
    current3.carrito = solicitados2;
    var f1 = () => Navigator.push(context, MaterialPageRoute(builder: (context) => OrderCard(actual)));
    var f2 = () => Navigator.push(context, MaterialPageRoute(builder: (context) => Menu(actual)));
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.only(left: 3.0, right: 3.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            GestureDetector(
              onTap: f2,
              child: Hero(
                tag: "hero_menu",
                child: Material(
                  type: MaterialType.transparency,
                  child: Icon(
                    Icons.menu,
                    color: Colors.white,
                    size: 50,
                  ),
                ),
                createRectTween: (begin, end) {
                  return CustomRectTween(begin: begin, end: end);
                },
              ),
            ),
            Image.asset(
              'assets/img/logo.png',
              height: 85,
            ),
            GestureDetector(
              onTap: (){(actual.carrito.isNotEmpty)?f1():showAlert(context);},
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
