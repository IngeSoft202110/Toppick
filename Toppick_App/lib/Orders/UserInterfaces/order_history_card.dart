import 'package:Toppick_App/Orders/Models/pedido.dart';
import 'package:Toppick_App/Products/Models/producto.dart';
import 'package:Toppick_App/Shops/Models/tienda.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class OrderHistoryCard extends StatefulWidget {
  OrderHistoryCard(this.current, this.number);
  final Pedido current;
  final int number;
  @override
  _OrderHistoryCardState createState() => _OrderHistoryCardState();
}

class _OrderHistoryCardState extends State<OrderHistoryCard> {
  Tienda? store;

  showRejection(BuildContext context, String razones){
  Widget okButton = TextButton(
    child: Text("OK"),
    onPressed: () {Navigator.pop(context);}
  );
  AlertDialog alert = AlertDialog(
    title: Text("Razones de rechazo", style: TextStyle(color: Color(0xFFD76060)),),
    content: Text("$razones"),
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

  List<Widget> loadOrderInformation(){
    List<Widget> result = [];
    result.add(
      Padding(
        padding: const EdgeInsets.only(left: 10.0, bottom: 5.0, top: 5.0),
        child: Text("Pedido ${widget.number}", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
      ),
    );
    Map<Producto, int> products = widget.current.carrito[this.store]!;
    products.forEach((key, value) {
      result.add(
        Padding(
          padding: const EdgeInsets.only(left: 10.0),
          child: Row(
            children: [
              Container(width: 150, child: Text("${key.name} ", overflow: TextOverflow.ellipsis)),
              Text("  X $value")
            ],
          ),
        )
      );
    });
    var formatter = NumberFormat('#,###,000');
    result.add(
      Padding(
        padding: const EdgeInsets.only(left: 10.0, top: 5.0),
        child: Text("Valor: \$${formatter.format(widget.current.costoTotal)}", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
      )
    );
    DateFormat dateFormat = DateFormat("dd/MM/yyyy").add_jm();
    String time = dateFormat.format(widget.current.fechaReclamo);
    result.add(
      Padding(
        padding: const EdgeInsets.only(left: 10.0, top: 5.0, bottom: 5.0),
        child: Text("Reclamo: $time", style: TextStyle(color: Color(0xFF0CC665), fontWeight: FontWeight.bold),),
      )
    );
    print(widget.current.estadoPedido);
    if(widget.current.estadoPedido == "Rechazado"){
      result.add(
        Container(
          padding: const EdgeInsets.only(left: 10.0, right: 10.0),
          child: IconButton(
            icon: Icon(Icons.info, color: Color(0xFFD76060),),
            onPressed: () => showRejection(context, widget.current.razonRechazo),
          )//Text("Razon rechazo: ${widget.current.razonRechazo}", style: TextStyle(color: Color(0xFFD76060)),),
        )
      );
    }
    return result;
  }
  @override
  Widget build(BuildContext context) {
    this.store = widget.current.carrito.keys.first;
    return Padding(
      padding: const EdgeInsets.only(left: 20.0, right: 20.0, bottom: 20.0),
      child: Container(
        decoration: BoxDecoration(
          color:Color(0xFFFFFEEE),
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black38, blurRadius: 15.0, offset: Offset(0.0, 5.0)
            )
          ]
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: loadOrderInformation()
            ),
            Expanded(
              child: Column(
                children: <Widget>[
                  Text("${widget.current.estadoPedido}", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15,color: Color(0xFF0791E6)),),
                  Divider(color: Color(0xFFFFFEEE)),
                  Text("${store!.name}", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25, color: Color(0xFFD76060)),),
                  Divider(color: Color(0xFFFFFEEE)),
                  Divider(color: Color(0xFFFFFEEE)),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}