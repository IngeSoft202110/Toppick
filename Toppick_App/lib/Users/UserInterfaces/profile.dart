import 'package:Toppick_App/GeneralUserInterfaces/generic_button.dart';
import 'package:Toppick_App/GeneralUserInterfaces/gradiant.dart';
import 'package:Toppick_App/GeneralUserInterfaces/header.dart';
import 'package:Toppick_App/Orders/Models/daviplata.dart';
import 'package:Toppick_App/Orders/Models/nequi.dart';
import 'package:Toppick_App/Orders/Models/pedido.dart';
import 'package:Toppick_App/Orders/Models/pse.dart';
import 'package:Toppick_App/Orders/UserInterfaces/favorite_order_card.dart';
import 'package:Toppick_App/Orders/UserInterfaces/payment_method_card.dart';
import 'package:Toppick_App/Products/Models/producto.dart';
import 'package:Toppick_App/Shops/Models/tienda.dart';
import 'package:Toppick_App/Users/Models/cliente.dart';
import 'package:flutter/material.dart';

Pedido current2 = Pedido(0, DateTime.now(), 9000, DateTime.now(), "Cocinando");
Map<Tienda?, Map<Producto, int>> solicitados1 = {Tienda(0, "Tepanyaki","","","","Abierto",""):{
  Producto(1, "Pescadito", "descripcion", 3000, 20, 4.5, "URL", "Otros", "Horneado") : 2,
  Producto(2, "Té", "Té frio", 2000, 20, 4.5, "URL", "Bebidas", "Tés"): 1,
  Producto(3, "Maní", "descripcion", 1000, 0, 4.0, "URL", "Empaquetados", "Salados"): 1
}};
Map<Tienda?, Map<Producto, int>> solicitados2 = {Tienda(0, "La central","","","","Abierto",""):{
  Producto(1, "Pescadito", "descripcion", 3000, 20, 4.5, "URL", "Otros", "Horneado") : 2,
  Producto(2, "Té", "Té frio", 2000, 20, 4.5, "URL", "Bebidas", "Tés"): 1,
  Producto(3, "Maní", "descripcion", 1000, 0, 4.0, "URL", "Empaquetados", "Salados"): 1,
  Producto(4, "Hamburguesa", "descripcion", 1000, 0, 4.0, "URL", "Empaquetados", "Salados"): 1,
}};

Pedido current3 = Pedido(0, DateTime.now(), 9000, DateTime.now(), "Listo");


class Profile extends StatelessWidget {
  Profile(this.actual);
  final Pedido actual;
  final List<Pedido> favoritos = [current2, current3];
  final Cliente clienteActual = Cliente(1, "Juan Francisco", "Hamon Garzon", "3043045566", "hamon_juan@javeriana.edu.co");

  @override
  Widget build(BuildContext context) {
    clienteActual.metodos = [DaviPlata(1, 1000000, 3044576728), Nequi(2, 20000, 3103104040), PSE(3, 4000, 250025002267)];
    current2.carrito = solicitados1;
    current3.carrito = solicitados2;
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
                Padding(
                  padding: const EdgeInsets.only(bottom: 15.0),
                  child: Header(this.actual),
                ),
                Container(
                  decoration: BoxDecoration(borderRadius: BorderRadius.only(topLeft: Radius.circular(40), topRight: Radius.circular(40)), color: Color(0xFFFFFEEE),),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              padding: EdgeInsets.only(left:5.0),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                shape: BoxShape.circle,
                              ),
                              child: Icon(Icons.person, size: 100,),
                            ),
                            Flexible(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Column(
                                    children: [
                                      Text(this.clienteActual.nombres,  style: TextStyle(color: Color(0xFFD76060), fontSize: 25, fontWeight: FontWeight.bold),),
                                      Text(this.clienteActual.apellidos, style: TextStyle(color: Color(0xFFD76060), fontSize: 25, fontWeight: FontWeight.bold),)
                                    ],
                                  ),
                                  Text(this.clienteActual.correo, style: TextStyle(color: Color(0xFFB7B7B7), fontSize: 12)),
                                  Text(this.clienteActual.celular, style: TextStyle(color: Color(0xFFB7B7B7), fontSize: 12)),
                                ],
                              ),
                            ),
                            IconButton(icon: Icon(Icons.edit), onPressed: ()=>{})
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
                          child: Text("Tus métodos de pago", style: TextStyle(color: Color(0xFFD76060), fontSize: 25, fontWeight: FontWeight.bold),),
                        ),
                        SizedBox(
                          height: 230,
                          child: ListView.builder(
                            itemCount: this.clienteActual.metodos.length,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (BuildContext context, int index) => PaymentMethodCard(this.clienteActual.metodos[index])
                          )
                        ),
                        if(this.clienteActual.metodos.length < 3) Center(child: GenericButton("Agregar método de pago", Color(0xFF0CC665), 200, 30, 15, 5, 0, 5, 15, 15, ()=>{})),
                        Padding(
                          padding: const EdgeInsets.only(top: 20.0, bottom: 10.0),
                          child: Text("Pedidos favoritos", style: TextStyle(color: Color(0xFFD76060), fontSize: 25, fontWeight: FontWeight.bold),),
                        ),
                        SizedBox(
                          height: 230,
                          child: ListView.builder(
                            itemCount: this.favoritos.length,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (BuildContext context, int index) => FavoriteOrderCard(index+1, this.favoritos[index])
                          )
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}