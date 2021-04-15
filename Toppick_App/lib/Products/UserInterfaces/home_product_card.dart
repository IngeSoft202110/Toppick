import 'package:Toppick_App/Orders/Models/pedido.dart';
import 'package:Toppick_App/Products/Bloc/product_controller.dart';
import 'package:Toppick_App/Products/Models/acompanamiento.dart';
import 'package:Toppick_App/Products/Models/especialidad.dart';
import 'package:Toppick_App/Products/UserInterfaces/personalize.dart';
import 'package:Toppick_App/Shops/Bloc/shop_controller.dart';
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

Widget comments(TextEditingController controller) {
  return Container(
    margin: EdgeInsets.only(top: 15.0, left: 30.0, right: 15.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("¿Cómo lo quieres?",
            style: TextStyle(
                color: Color(0xFFD76060),
                fontSize: 25,
                fontWeight: FontWeight.bold)),
        TextField(
          maxLength: 150,
          maxLines: 5,
          minLines: 1,
          controller: controller,
          keyboardType: TextInputType.text,
          decoration: InputDecoration(
            hintText: "indicaciones de preparación",
            hintStyle: TextStyle(color: Color(0xFFB7B7B7)),
          ),
        ),
      ],
    ),
  );
}

showCorrectAdd(BuildContext context, String productName, ShopController shopController, Tienda shopSelected) {
  Widget okButton = TextButton(
    child: Text("OK"),
    onPressed: () { Navigator.of(context).pop();},
  );
  AlertDialog alert = AlertDialog(
    title: Text("Producto seleccionado", style: TextStyle(color: Color(0xFF0CC665)),),
    content: Text("Se ha agregado $productName al pedido."),
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
  shopController.getShopSchedule(shopSelected.id, shopSelected);
}

showStoreWarning(BuildContext context) {
  Widget okButton = TextButton(
    child: Text("OK"),
    onPressed: () { Navigator.of(context).pop();},
  );
  AlertDialog alert = AlertDialog(
    title: Text("No se ha seleccionado un punto de venta", style: TextStyle(color: Color(0xFFD76060)),),
    content: Text("Por favor seleccione alguno de los puntos de venta para poder agregar el producto al pedido."),
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

// ignore: must_be_immutable
class HomeProductCard extends StatelessWidget {
  HomeProductCard(
      this.selected, this.shopSelected, this.current);
  final dynamic selected;
  List<Tienda> available = [];
  final Pedido current;
  int quantity = 1;
  Tienda? shopSelected;
  TextEditingController textController = TextEditingController();
  ProductController controller = ProductController();
  ShopController shopController = ShopController();

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

  void addProduct(BuildContext context, TextEditingController controller) {
    if(this.controller.hasComments(this.selected)){
      this.selected.addComments(controller.text);
    }
    if (shopSelected!.id != -1) {
      if (this.current.storeIsInCurrentOrder(this.shopSelected!)) {
        if (this.current.productInShopOrder(shopSelected!, selected)) {
          this.current.addQuantityToExistingProduct(shopSelected!, selected, quantity);
          showCorrectAdd(context, this.selected.name, this.shopController, this.shopSelected!);
        } else {
          this.current.addProductToSelectedStore(shopSelected!, selected, quantity);
          showCorrectAdd(context, this.selected.name, this.shopController, this.shopSelected!);
        }
      } else {
        this.current.addStoreWithProducts(shopSelected!, selected, quantity);
        showCorrectAdd(context, this.selected.name, this.shopController, this.shopSelected!);
      }
    } else {
      showStoreWarning(context);
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
                    if (this.selected is Especialidad)
                      FutureBuilder(
                        future: this.controller.getAditionsOfProduct(this.selected.id),
                        builder: (context,  AsyncSnapshot<List<Acompanamiento>> snapshot){
                          switch(snapshot.connectionState){
                          case ConnectionState.none:
                            break;
                          case ConnectionState.waiting:
                            break;
                          case ConnectionState.active:
                            break;
                          case ConnectionState.done:
                          this.selected.acompanamientos = snapshot.data!;
                            return Center(child: AddTodoButton(this.selected));
                        }
                        return Container(
                          padding: const EdgeInsets.only(top: 150.0, left: 150, right: 150),
                          height: 250,
                          child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Colors.red),)
                        );
                        }
                      ),
                    if (controller.hasComments(this.selected))
                      comments(this.textController),
                    place(),
                    FutureBuilder(
                      future: this.shopController.getAvailableShopsByProduct(this.selected.id),
                      builder: (context,  AsyncSnapshot<List<Tienda>> snapshot){
                        switch(snapshot.connectionState){
                          case ConnectionState.none:
                            break;
                          case ConnectionState.waiting:
                            break;
                          case ConnectionState.active:
                            break;
                          case ConnectionState.done:
                          this.available = snapshot.data!;
                            return RadioButtonListStore(this.selected, this.available,
                              this.shopSelected, updateStore);
                        }
                        return Container(
                          padding: const EdgeInsets.only(top: 150.0, left: 150, right: 150),
                          height: 250,
                          child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Colors.red),)
                        );
                      }
                    ),
                    
                    Center(
                      child: GenericButton("Ver Reseñas", Color(0xFF2196F3),
                          274, 45, 15.0, 0, 0, 0, 22, 30, () => {}),
                    ),
                    Center(
                      child: GenericButton("Agregar", Color(0xFF0CC665), 274,
                          45, 15.0, 0, 0, 0, 22, 30, () => addProduct(context, this.textController)),
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
