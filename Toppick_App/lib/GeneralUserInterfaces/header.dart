import 'package:Toppick_App/Orders/Models/pedido.dart';
import 'package:Toppick_App/Orders/UserInterfaces/active_orders_home.dart';
import 'package:Toppick_App/Orders/UserInterfaces/order_card.dart';
import 'package:Toppick_App/Products/Models/producto.dart';
import 'package:Toppick_App/Shops/Models/tienda.dart';
import 'package:flutter/material.dart';

Pedido current2 = Pedido(0, DateTime.now(), 9000, 0, "Cocinando");
Map<Tienda?, Map<Producto, int>> solicitados1 = {Tienda(0, "Tepanyaki","","","","",true,""):{
  Producto(0, "Pescadito", 6000, "", 0, 4.0, "") : 2,
  Producto(0, "Té", 2000, "", 0, 4.0, "") : 1,
  Producto(0, "Maní", 1000, "", 0, 4.0, "") : 1
}};
Map<Tienda?, Map<Producto, int>> solicitados2 = {Tienda(0, "La central","","","","",true,""):{
  Producto(0, "Pescadito", 6000, "", 0, 4.0, "") : 2,
  Producto(0, "Té", 2000, "", 0, 4.0, "") : 1,
  Producto(0, "Maní", 1000, "", 0, 4.0, "") : 1
}};

Pedido current3 = Pedido(0, DateTime.now(), 9000, 0, "Listo");

List<Pedido> pedidos = [current2, current3,];

class Header extends StatelessWidget {
  Header(this.actual);
  final Pedido actual;
  @override
  Widget build(BuildContext context) {
    current2.carrito = solicitados1;
    current3.carrito = solicitados2;
    var f1 = () => Navigator.push(context, MaterialPageRoute(builder: (context) => OrderCard(actual)));
    var f2 = () => Navigator.push(context, MaterialPageRoute(builder: (context) => ActiveOrdersHome(pedidos, this.actual)));
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.only(left: 3.0, right: 3.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            GestureDetector(
              onTap: f2,
              child: Icon(
                Icons.menu,
                color: Colors.white,
                size: 50,
              ),
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
