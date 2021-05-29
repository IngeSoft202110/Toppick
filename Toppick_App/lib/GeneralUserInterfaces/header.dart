import 'package:Toppick_App/Orders/Models/pedido.dart';
import 'package:Toppick_App/Orders/UserInterfaces/order_card.dart';
import 'package:Toppick_App/Products/UserInterfaces/custom_rect_tween.dart';
import 'package:flutter/material.dart';
import 'package:badges/badges.dart';
import 'menu.dart';

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

class Header extends StatefulWidget {
  Header(this.actual,this.prefs,{this.hKey, this.showCart=false}):super(key: hKey);
  final Pedido actual;
  final prefs;
  final GlobalKey<HeaderState>? hKey;
  final bool showCart;
  @override
  HeaderState createState() => HeaderState();
}

class HeaderState extends State<Header> {

  void recalculate(int nCants, bool empty){
    setState(() {
      if(empty){
        widget.prefs.setInt('cantidades', 0);
      }
      else{
        int current = widget.prefs.getInt('cantidades');
        widget.prefs.setInt('cantidades', current+nCants);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    var f1 = () => Navigator.push(context, MaterialPageRoute(builder: (context) => OrderCard(widget.actual, widget.key)));
    var f2 = () => Navigator.push(context, MaterialPageRoute(builder: (context) => Menu(widget.actual, this.widget.prefs)));
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.only(left: 3.0, right: 3.0),
        child: Row(
          children: <Widget>[
            Container(
              alignment: Alignment.centerLeft,
              padding: const EdgeInsets.only(left: 5.0),
              width: width*0.33,
              child: GestureDetector(
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
            ),
            Container(
              width: width*0.35,
              child: Image.asset(
                'assets/img/logo.png',
                height: 85,
              ),
            ),
            if(widget.showCart)
            Container(
              width: width*0.29,
              alignment: Alignment.centerRight,
              child: GestureDetector(
                onTap: (){(widget.actual.carrito.isNotEmpty)?f1():showAlert(context);},
                child: Badge(
                  badgeContent: Text('${widget.prefs.getInt('cantidades')}'),
                  badgeColor: Colors.white,
                  child: Icon(
                    Icons.shopping_bag_outlined,
                    color: Colors.white,
                    size: 50,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
