import 'package:Toppick_App/Orders/Models/pedido.dart';
import 'package:flutter/material.dart';
import 'package:Toppick_App/Products/UserInterfaces/add_substract.dart';
import 'package:Toppick_App/Products/UserInterfaces/combo_product_card.dart';
import '../../GeneralUserInterfaces/generic_button.dart';
import '../../Shops/Models/tienda.dart';
import '../Models/combo.dart';
import 'radio_buttons.dart';

Widget image(String pathImage, double w, double h) {
  return Container(
    height: h,
    width: w,
    decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(30.0),
            bottomRight: Radius.circular(30.0)),
        image:
            DecorationImage(fit: BoxFit.cover, image: AssetImage(pathImage))),
  );
}

Widget productHead(String name, Combo a, Function(String type) notifyParent) {
  return Container(
    margin: EdgeInsets.only(top: 15.0, left: 30.0),
    width: double.infinity,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          name,
          style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 40,
              color: Color(0xFFD76060)),
        ),
        AddSubstract(a, notifyParent),
      ],
    ),
  );
}

Widget place() {
  return Container(
    margin: EdgeInsets.only(top: 20.0, left: 30.0),
    child: Text(
      "Ordenar en:",
      style: TextStyle(
          fontWeight: FontWeight.w700, fontSize: 30, color: Color(0xFFD76060)),
    ),
  );
}

Widget productDescription(String description) {
  return Container(
    margin: EdgeInsets.only(top: 15.0, left: 30.0, right: 10.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Descripción",
          style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 30,
              color: Color(0xFFD76060)),
        ),
        Text(
          description,
          style: TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: 22,
              color: Color(0xFFB7B7B7)),
          textAlign: TextAlign.left,
        )
      ],
    ),
  );
}

Widget comboProductList(Combo a) {
  List<Widget> aux = [];
  for (var p in a.productos) {
    aux.add(ComboProductCard(p));
  }
  return Container(
    height: 250,
    width: double.infinity,
    child: Container(
      width: double.infinity,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: aux,
      ),
    ),
  );
}

// ignore: must_be_immutable
class HomeCombosCard extends StatelessWidget {
  HomeCombosCard(this.selected, this.available, this.storeID, this.current);
  final Combo selected;
  final List<Tienda> available;
  final int storeID;
  final Pedido current;
  int quantity = 1;
  Tienda? shopSelected;

  void updateStore(Tienda? selected){
    this.shopSelected = selected;
  }

  void updateQuantity(String type){
    if(type=="Add"){
      this.quantity+=1;
    }else if(type == "Substract"){
      this.quantity-=1;
    }
  }

  void addProduct (){
    if(this.current.carrito.containsKey(shopSelected)){
      if(this.current.carrito[shopSelected]!.containsKey(selected)){
        int newValue = this.current.carrito[shopSelected]![selected]! + quantity;
        this.current.carrito[shopSelected]![selected] = newValue;
      }else{
        this.current.carrito[shopSelected]!.addAll({this.selected: this.quantity});
      }
    }else{
      this.current.carrito[shopSelected] = {this.selected: this.quantity};
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        scrollDirection: Axis.vertical,
        children: [
          Container(
            width: double.infinity,
            height: MediaQuery.of(context).size.height,
            color: Color(0xFFFFFEEE),
            child: ListView(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    image("assets/img/pescadito.jpg", double.infinity, 315),
                    productHead(this.selected.name, this.selected, updateQuantity),
                    productDescription(this.selected.description),
                    Container(
                      margin:
                          EdgeInsets.only(top: 10, left: 30.0, bottom: 10.0),
                      child: Text(
                        "Contenido del combo",
                        style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 30,
                            color: Color(0xFFD76060)),
                      ),
                    ),
                    comboProductList(this.selected),
                    place(),
                    RadioButtonListStore(
                        this.selected, this.available, this.storeID, updateStore),
                    Center(
                      child: GenericButton("Ver Reseñas", Color(0xFF2196F3),
                          274, 45, 15.0, 0, 0, 0, 22, 30, () => {}),
                    ),
                    Center(
                      child: GenericButton("Agregar", Color(0xFF0CC665), 274,
                          45, 15.0, 0, 0, 0, 22, 30, () => addProduct()),
                    ),
                    SizedBox(
                      height: 40,
                    )
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
