import 'package:Toppick_App/GeneralUserInterfaces/gradiant.dart';
import 'package:Toppick_App/GeneralUserInterfaces/header.dart';
import 'package:Toppick_App/Orders/Bloc/order_controller.dart';
import 'package:Toppick_App/Orders/Models/pedido.dart';
import 'package:Toppick_App/Orders/UserInterfaces/active_order_card.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class ActiveOrdersHome extends StatelessWidget {
  ActiveOrdersHome(this.actual);
  List<Pedido> activeOrders = [];
  final Pedido actual;
  final OrderController controller = OrderController();

  List<Widget> fill(BuildContext context) {
    List<Widget> result = [];
    result.add(Center(
      child: Padding(
        padding: const EdgeInsets.only(top: 10.0, bottom: 20.0),
        child: Text(
          "Pedidos activos",
          style: TextStyle(
              color: Color(0xFFD76060),
              fontSize: 35,
              fontWeight: FontWeight.bold),
        ),
      ),
    ));
    int count = 1;
    this.activeOrders.forEach((element) {
      result.add(ActiveOrderCard(element, count));
      count += 1;
    });
    result.add(SizedBox(
      height: 10,
    ));
    return result;
  }

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
                Padding(
                  padding: const EdgeInsets.only(bottom: 15.0),
                  child: Header(this.actual),
                ),
                FutureBuilder(
                    future: controller.getActiveOrders(1),
                    builder: (context, AsyncSnapshot<List<Pedido>> snapshot) {
                      switch (snapshot.connectionState) {
                        case ConnectionState.none:
                          break;
                        case ConnectionState.waiting:
                          break;
                        case ConnectionState.active:
                          break;
                        case ConnectionState.done:
                          if (snapshot.hasData) {
                            this.activeOrders = snapshot.data!;
                            return Container(
                              decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(40)),
                                color: Color(0xFFFFFEEE),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: fill(context),
                              ),
                            );
                          } else {
                            return Container(
                              decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(40)),
                                color: Color(0xFFFFFEEE),
                              ),
                              height: MediaQuery.of(context).size.height * 0.80,
                              child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          top: 10.0, bottom: 20.0),
                                      child: Text(
                                        "Pedidos activos",
                                        style: TextStyle(
                                            color: Color(0xFFD76060),
                                            fontSize: 35,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    Text(
                                      "No hay pedidos activos en este momento.",
                                      style: TextStyle(
                                          color: Color(0xFF0791E6),
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ]),
                            );
                          }
                      }
                      return Container(
                          padding: const EdgeInsets.only(
                              top: 150.0, left: 150, right: 150),
                          height: 250,
                          child: CircularProgressIndicator(
                            valueColor:
                                AlwaysStoppedAnimation<Color>(Colors.red),
                          ));
                    }),
              ],
            )),
      ],
    ));
  }
}
