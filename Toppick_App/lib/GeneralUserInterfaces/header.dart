import 'package:Toppick_App/Orders/Models/pedido.dart';
import 'package:Toppick_App/Orders/UserInterfaces/active_orders_home.dart';
import 'package:Toppick_App/Orders/UserInterfaces/order_card.dart';
import 'package:Toppick_App/Products/Models/bebida.dart';
import 'package:Toppick_App/Products/Models/empaquetados.dart';
import 'package:Toppick_App/Products/Models/otros.dart';
import 'package:Toppick_App/Products/Models/producto.dart';
import 'package:Toppick_App/Shops/Models/tienda.dart';
import 'package:flutter/material.dart';

Pedido current2 = Pedido(0, DateTime.now(), 9000, DateTime.now(), "Cocinando");
Map<Tienda?, Map<Producto, int>> solicitados1 = {Tienda(0, "Tepanyaki","",[],"","",true,""):{
  Otros("Horneado", 1, "Pescadito", 3000, 20, 4.5, "URL", "Otros") : 2,
  Bebida(50, "Tés", 2, "Té", 2000, 20, 4.5, "URL", "Bebidas"): 1,
  Empaquetado(25, "Manís", 3, "Maní", 1000, 0, 4.0, "URL", "Empaquetados"): 1
}};
Map<Tienda?, Map<Producto, int>> solicitados2 = {Tienda(0, "La central","",[],"","",true,""):{
  Otros("Horneado", 1, "Pescadito", 3000, 20, 4.5, "URL", "Otros") : 2,
  Bebida(50, "Tés", 2, "Té", 2000, 20, 4.5, "URL", "Bebidas"): 1,
  Empaquetado(25, "Manís", 3, "Maní", 1000, 0, 4.0, "URL", "Empaquetados"): 1
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
