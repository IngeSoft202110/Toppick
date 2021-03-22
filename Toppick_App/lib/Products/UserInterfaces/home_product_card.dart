import 'package:Toppick_App/Orders/Models/pedido.dart';
import 'package:Toppick_App/Products/UserInterfaces/personalize.dart';
import 'package:flutter/material.dart';
import 'package:Toppick_App/Products/UserInterfaces/add_substract.dart';
import '../../GeneralUserInterfaces/generic_button.dart';
import '../../Shops/Models/tienda.dart';
import '../Models/producto.dart';
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

Widget productHead(
    String name, Producto a, Function(String type) notifyParent) {
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

Widget place() {
  return Container(
    margin: EdgeInsets.only(top: 15.0, left: 30.0),
    child: Text(
      "Ordenar en:",
      style: TextStyle(
          fontWeight: FontWeight.w700, fontSize: 30, color: Color(0xFFD76060)),
    ),
  );
}

// ignore: must_be_immutable
class HomeProductCard extends StatelessWidget {
  HomeProductCard(
      this.selected, this.available, this.shopSelected, this.current);
  final dynamic selected;
  final List<Tienda> available;
  final Pedido current;
  int quantity = 1;
  Tienda? shopSelected;

  void updateStore(Tienda? selected) {
    this.shopSelected = selected;
  }

  void updateQuantity(String type) {
    if (type == "Add") {
      this.quantity += 1;
    } else if (type == "Substract") {
      this.quantity -= 1;
    }
  }

  void addProduct() {
    if (shopSelected!.id != -1) {
      if (this.current.carrito.containsKey(shopSelected)) {
        if (this.current.carrito[shopSelected]!.containsKey(selected)) {
          int newValue =
              this.current.carrito[shopSelected]![selected]! + quantity;
          this.current.carrito[shopSelected]![selected] = newValue;
        } else {
          this
              .current
              .carrito[shopSelected]!
              .addAll({this.selected: this.quantity});
        }
      } else {
        this.current.carrito[shopSelected] = {this.selected: this.quantity};
      }
    } else {
      print("No se ha seleccionado una tienda");
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
                    productHead(
                        this.selected.name, this.selected, updateQuantity),
                    productDescription(this.selected.description),
                    if (this.selected.category == "A la carta")
                      AddTodoButton(this.selected),
                    place(),
                    RadioButtonListStore(this.selected, this.available,
                        this.shopSelected, updateStore),
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
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
