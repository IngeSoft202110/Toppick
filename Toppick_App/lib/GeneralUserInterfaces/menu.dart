import 'package:Toppick_App/GeneralUserInterfaces/generic_button.dart';
import 'package:Toppick_App/Orders/Models/pedido.dart';
import 'package:Toppick_App/Orders/UserInterfaces/active_orders_home.dart';
import 'package:Toppick_App/Orders/UserInterfaces/order_history_home.dart';
import 'package:Toppick_App/Products/UserInterfaces/custom_rect_tween.dart';
import 'package:Toppick_App/Users/UserInterfaces/home_screen.dart';
import 'package:flutter/material.dart';

class Menu extends StatelessWidget {
  Menu(this.actual);
  final Pedido actual;
  @override
  Widget build(BuildContext context) {
    var pedidosActivos = () {Navigator.pop(context); Navigator.push(context, MaterialPageRoute(builder: (context) => ActiveOrdersHome(this.actual)));};
    var mainPage = () {Navigator.pop(context); Navigator.push(context, MaterialPageRoute(builder: (context) => HomeScreen(this.actual)));};
    var historialPedidos = () {Navigator.pop(context); Navigator.push(context, MaterialPageRoute(builder: (context) => OrderHistoryHome(this.actual)));};
    var perfil = () {Navigator.pop(context); /* PUSH PARA LA PANTALLA DE PERFIL */};
    var cerrarSesion = () {/* PUSH A PANTALLA INICIAL, VERIFICANDO CONDICIONES DE LA HISTORIA (pushAndRemoveUntil) */};
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: MediaQuery.of(context).size.height,
        color: Color(0xFFFFFEEE),
        child: Column(
          children: <Widget>[
            SafeArea(child: Container(),),
            Row(
              children: <Widget>[
                Hero(
                  tag: "hero_menu",
                  child: Padding(
                    padding: const EdgeInsets.only(left:17.0, top: 22.0),
                    child: GestureDetector(child: Icon(Icons.close), onTap: ()=>{Navigator.pop(context)},),
                  ),
                  createRectTween: (begin, end) {
                    return CustomRectTween(begin: begin, end: end);
                  },
                ),
                Expanded(child: Container(),),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15.0, right: 15.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Flexible(
                    child: Text("¡Hola Pepito!", style: TextStyle(color: Color(0xFFD76060), fontSize: 30, fontWeight: FontWeight.bold),)
                  ),
                  Container(
                    padding: EdgeInsets.only(left:5.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(Icons.person, size: 100,),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Text("Menú de opciones", style: TextStyle(color: Color(0xFFD76060), fontSize: 30, fontWeight: FontWeight.bold)),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Column(
                  children: <Widget>[
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Color(0xFFD76060),width: 2),
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                      child: IconButton(icon: Icon(Icons.home), onPressed: mainPage, iconSize: 100,),
                    ),
                    Text("Home", style: TextStyle( fontSize: 30, fontWeight: FontWeight.bold)),
                  ],
                ),
                Column(
                  children: <Widget>[
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Color(0xFFD76060),width: 2),
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                      child: IconButton(icon: Icon(Icons.person), onPressed: perfil, iconSize: 100,),
                    ),
                    Text("Perfil", style: TextStyle( fontSize: 30, fontWeight: FontWeight.bold)),
                  ],
                )
              ],
            ),
            Divider(color: Color(0xFFFFFEEE),),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Column(
                  children: <Widget>[
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Color(0xFFD76060),width: 2),
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                      child: IconButton(icon: Icon(Icons.history), onPressed: historialPedidos, iconSize: 100,),
                    ),
                    Text("Historial", style: TextStyle( fontSize: 30, fontWeight: FontWeight.bold)),
                    Text("pedidos", style: TextStyle( fontSize: 30, fontWeight: FontWeight.bold)),
                  ],
                ),
                Column(
                  children: <Widget>[
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Color(0xFFD76060),width: 2),
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                      child: IconButton(icon: Icon(Icons.list), onPressed: pedidosActivos,iconSize: 100,),
                    ),
                    Text("Pedidos", style: TextStyle( fontSize: 30, fontWeight: FontWeight.bold)),
                    Text("activos", style: TextStyle( fontSize: 30, fontWeight: FontWeight.bold)),
                  ],
                )
              ],
            ),
            GenericButton("Cerrar sesión", Color(0xFFFF441F), 250, 50, 15, 5, 5, 5, 30, 10, ()=>{}),
          ],
        ),
      ),
    );
  }
}