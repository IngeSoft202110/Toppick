import 'package:Toppick_App/Orders/Models/pedido.dart';
import 'package:Toppick_App/Orders/UserInterfaces/ordercard.dart';
import 'package:flutter/material.dart';

class Header extends StatelessWidget {
  Header(this.actual);
  final Pedido actual;
  @override
  Widget build(BuildContext context) {
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
