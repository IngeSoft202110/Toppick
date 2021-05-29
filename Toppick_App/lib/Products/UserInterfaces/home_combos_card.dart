import 'package:Toppick_App/Orders/Models/pedido.dart';
import 'package:Toppick_App/Products/Bloc/product_controller.dart';
import 'package:Toppick_App/Shops/Bloc/shop_controller.dart';
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
        borderRadius: BorderRadius.all(Radius.circular(30.0)),
        image:
            DecorationImage(fit: BoxFit.cover, image: AssetImage(pathImage))),
  );
}

Widget productHead(String name, Combo a, Function(String type) notifyParent) {
  return Container(
    margin: EdgeInsets.only(top: 15.0, left: 15.0),
    width: double.infinity,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(right: 15.0),
          child: Text(
            name,
            style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 30,
                color: Color(0xFFD76060)),
          ),
        ),
        AddSubstract(a, notifyParent),
      ],
    ),
  );
}

Widget place() {
  return Container(
    margin: EdgeInsets.only(top: 20.0, left: 15.0),
    child: Text(
      "Ordenar en:",
      style: TextStyle(
          fontWeight: FontWeight.w700, fontSize: 30, color: Color(0xFFD76060)),
    ),
  );
}

Widget productDescription(String description) {
  return Container(
    margin: EdgeInsets.only(top: 15.0, left: 15.0, right: 15.0),
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
  for (var p in a.products) {
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

showCorrectAdd(BuildContext context, String productName, ShopController shopController, Tienda shopSelected, String cookie) {
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
  shopController.getShopSchedule(shopSelected.id, shopSelected, cookie);
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
class HomeCombosCard extends StatelessWidget {
  HomeCombosCard(this.selected, this.shopSelected, this.current, this.prefs, this.header);
  final Combo selected;
  List<Tienda> available = [];
  final Pedido current;
  int quantity = 1;
  Tienda? shopSelected;
  ProductController controller = ProductController();
  ShopController shopController = ShopController();
  final prefs;
  final header;

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

  void addProduct (BuildContext context){
    if(shopSelected!.id !=-1){
      if (this.current.storeIsInCurrentOrder(this.shopSelected!)) {
        if (this.current.productInShopOrder(shopSelected!, selected)) {
          this.current.addQuantityToExistingProduct(shopSelected!, selected, quantity);
          showCorrectAdd(context, this.selected.name, this.shopController, this.shopSelected!, this.prefs.getString('cookie'));
          header.key.currentState!.recalculate(quantity, false);
        } else {
          this.current.addProductToSelectedStore(shopSelected!, selected, quantity);
          showCorrectAdd(context, this.selected.name, this.shopController, this.shopSelected!, this.prefs.getString('cookie'));
          header.key.currentState!.recalculate(quantity, false);
        }
      } else {
        this.current.addStoreWithProducts(shopSelected!, selected, quantity);
        showCorrectAdd(context, this.selected.name, this.shopController, this.shopSelected!, this.prefs.getString('cookie'));
        header.key.currentState!.recalculate(quantity, false);
      }
    }else{
      showStoreWarning(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
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
                          EdgeInsets.only(top: 10, left: 15.0, bottom: 10.0),
                      child: Text(
                        "Contenido del combo",
                        style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 30,
                            color: Color(0xFFD76060)),
                      ),
                    ),
                    FutureBuilder(
                      future: controller.getComboProducts(this.selected.id, this.prefs.getString('cookie')),
                      builder: (context,  AsyncSnapshot<List<dynamic>> snapshot){
                        switch(snapshot.connectionState){
                          case ConnectionState.none:
                            break;
                          case ConnectionState.waiting:
                            break;
                          case ConnectionState.active:
                            break;
                          case ConnectionState.done:
                            if(snapshot.hasData){
                              this.selected.products = snapshot.data!;
                              return comboProductList(this.selected);
                            }else{
                              return Padding(
                                padding: EdgeInsets.only(top: 10.0),
                                child: Center(
                                  child: Text(
                                    "No se encontró el contenido del combo", 
                                    style: TextStyle(color: Color(0xFFFF441F), fontWeight: FontWeight.bold),
                                  )
                                ),
                              );
                            }
                        }
                        return Center(
                          child: Container(
                            padding: const EdgeInsets.all(10),
                            height: 50,
                            child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Colors.red),)
                          ),
                        );
                      }
                    ),
                    place(),
                    FutureBuilder(
                      future: this.shopController.getAvailableShopsByProduct(this.selected.id, this.prefs.getString('cookie')),
                      builder: (context,  AsyncSnapshot<List<Tienda>> snapshot){
                        switch(snapshot.connectionState){
                          case ConnectionState.none:
                            break;
                          case ConnectionState.waiting:
                            break;
                          case ConnectionState.active:
                            break;
                          case ConnectionState.done:
                            if(snapshot.hasData){
                              this.available = snapshot.data!;
                              return RadioButtonListStore(this.selected, this.available, this.shopSelected, updateStore);
                            }else{
                              return Padding(
                                padding: EdgeInsets.only(top: 10.0),
                                child: Center(
                                  child: Text(
                                    "No se encontraron puntos de venta", 
                                    style: TextStyle(color: Color(0xFFFF441F), fontWeight: FontWeight.bold),
                                  )
                                ),
                              );
                            }
                        }
                        return Center(
                          child: Container(
                            padding: const EdgeInsets.all(10),
                            height: 50,
                            child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Colors.red),)
                          ),
                        );
                      }
                    ),
                    Center(
                      child: GenericButton("Ver Reseñas", Color(0xFF2196F3),
                          274, 45, 15.0, 0, 0, 0, 22, 30, () => {}),
                    ),
                    Center(
                      child: GenericButton("Agregar", Color(0xFF0CC665), 274,
                          45, 15.0, 0, 0, 0, 22, 30, () => addProduct(context)),
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
