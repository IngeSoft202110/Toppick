import 'package:Toppick_App/Products/Models/producto.dart';
import 'package:Toppick_App/Products/Models/combo.dart';
import 'package:Toppick_App/GeneralUserInterfaces/listmaintext.dart';
import 'package:Toppick_App/GeneralUserInterfaces/gradiant.dart';
import 'package:Toppick_App/GeneralUserInterfaces/header.dart';
import 'package:Toppick_App/Products/UserInterfaces/productcard.dart';
import 'package:Toppick_App/Products/UserInterfaces/home_combos_card.dart';
import 'package:Toppick_App/Products/UserInterfaces/productcategorycard.dart';
import 'package:Toppick_App/Products/UserInterfaces/productcategorydisplay.dart';
import 'package:Toppick_App/GeneralUserInterfaces/search_bar_button.dart';
import 'package:flutter/material.dart';
import '../../Shops/Models/tienda.dart';
import 'package:Toppick_App/Products/UserInterfaces/home_product_card.dart';

List<String> categories = [
  'Horneados',
  'Empaquetados',
  'Bebidas',
  'A la carta',
  'Combos',
  'Otros',
];

List<String> descriptions = [
  'Productos horneados',
  'Productos Empaquetados',
  'Bebidas refrescantes',
  'Platos personalizables',
  'Combo de productos',
  'Productos que no cumplen con las caracteristicas de los demas',
];

List<String> logoPahts = [
  'assets/icons/horneados.png',
  'assets/icons/empaquetados.png',
  'assets/icons/bebidas.png',
  'assets/icons/alacarta.png',
  'assets/icons/combos.png',
  'assets/icons/otros.png',
];

/*Esta lista de productos se cargara con el ID de la tienda pasado al ProductList, si no le dan
ese parametro se listan todos los productos.*/

List<Producto> productList = [
  Producto(
      1,
      "Pescadito",
      3000,
      "NINFO",
      "Hojaldre relleno de arequipe, preparado por los mejores cocineros de toda la universidad.",
      20,
      4.5,
      "Horneados"),
  Producto(
      2,
      "Hamburguesa",
      10000,
      "NINFO",
      "Rica hamburguesa de la PUJ, preparada con la mejor carne y vegetales de Colombia.",
      20,
      4.5,
      "A la carta"),
  Producto(
      3,
      "Te",
      2000,
      "NINFO",
      "Te frio de la PUJ, perfecto para combinar con otras comidas que ofrece la universidad.",
      20,
      4.5,
      "Bebidas"),
  Producto(
      4,
      "Avena",
      1200,
      "NINFO",
      "Avena alpina como la conoces, simple pero muy rica.",
      20,
      4.5,
      "Bebidas"),
  Producto(5, "Chocorramo", 2000, "NINFO",
      "Ponque de vainilla recubierto en chocolate", 20, 4.5, "Empaquetados"),
  Producto(6, "Combo del mes", 5000, "NINFO", "Pescadito con Te.", 20, 4.5,
      "Combos"),
];

Combo quemado = Combo(
    DateTime.parse("2021-03-01 00:01:00Z"),
    DateTime.parse("2021-03-31 23:59:00Z"),
    productList,
    1,
    "Pescadito",
    3000,
    "NINFO",
    "Hojaldre relleno de arequipe, preparado por los mejores cocineros de toda la universidad.",
    20,
    4.5,
    "Horneados");

//tiendas para el widget de producto propio
List<Tienda> storeList = [
  Tienda(
    1,
    "La Central",
    "Cafeterias",
    "L-V: 6:00 A.M - 9:00 P.M \n S: 8:00 am a 4:00pm",
    "En el restaurante La Central brindamos gran variedad de productos: desayunos, almuerzos, comidas rapidas, pizzas, opciones para llevar y un espacio comodo, una experiencia unica ",
    "assets/img/central.PNG",
    true,
    "https://www.google.com/maps/dir//la+central+javeriana/data=!4m6!4m5!1m1!4e2!1m2!1m1!1s0x8e3f9b5f5fdde08f:0x19a674df1df81bae?sa=X&ved=2ahUKEwiBnN-jyKnvAhVju1kKHewoCP4Q9RcwAHoECAQQAw",
  ),
  Tienda(
    2,
    "La Pecera",
    "Cafeterias",
    "L-V: 6:00 A.M - 9:00 P.M \n S: 8:00 am a 4:00pm",
    "En el restaurante La Central brindamos gran variedad de productos: desayunos, almuerzos, comidas rapidas, pizzas, opciones para llevar y un espacio comodo, una experiencia unica ",
    "assets/img/central.PNG",
    true,
    "https://www.google.com/maps/dir//la+central+javeriana/data=!4m6!4m5!1m1!4e2!1m2!1m1!1s0x8e3f9b5f5fdde08f:0x19a674df1df81bae?sa=X&ved=2ahUKEwiBnN-jyKnvAhVju1kKHewoCP4Q9RcwAHoECAQQAw",
  )
];

List<Producto> filterProducts(List<Producto> products, String category) {
  List<Producto> filtered = [];
  for (Producto product in products) {
    if (product.category == category) filtered.add(product);
  }
  return filtered;
}

class ProductList extends StatefulWidget {
  ProductList({this.storeID = -1});
  final int storeID;
  @override
  ProductListState createState() => ProductListState();
}

class ProductListState extends State<ProductList> {
  List<ProductCategoryCard> widgets = [];
  String currentTitle = "";
  String currentDescription = "";
  ListView products = ListView(
    children: <Widget>[],
  );

  Widget selectProductsFromCategory(BuildContext context, int index) {
    return Padding(
      padding: const EdgeInsets.only(left: 15.0, bottom: 25.0),
      child: GestureDetector(
        onTap: () {
          setState(() {
            ProductCategoryCard selectedCard = widgets[index];
            if (selectedCard != null) {
              this.currentTitle = selectedCard.categoryName;
              this.currentDescription = selectedCard.categoryDescription;
              List<Producto> selected =
                  filterProducts(productList, this.currentTitle);
              this.products = ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: selected.length,
                  itemBuilder: (BuildContext context, int index) {
                    return GestureDetector(
                      onTap: () => {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    (selected[index].category == "Combos")
                                        ? HomeCombosCard(
                                            quemado, storeList, widget.storeID)
                                        : HomeProductCard(selected[index],
                                            storeList, widget.storeID)))
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(left: 15.0),
                        child: ProductCard(selected[index]),
                      ),
                    );
                  });
            }
          });
        },
        child: widgets[index],
      ),
    );
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
                Header(),
                SearchButton("Buscar productos", 3),
                ListMainText("Escoge la", "comida que amas"),
                Padding(
                  padding: const EdgeInsets.only(
                      top: 10.0, left: 10.0, bottom: 10.0),
                  child: Container(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Categorias",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: 25),
                    ),
                  ),
                ),
                SizedBox(
                  height: 150,
                  child: ListView.builder(
                    itemCount: categories.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: selectProductsFromCategory,
                  ),
                ),
                ProductCategoryDisplay(
                    this.currentTitle, this.currentDescription, this.products),
                SizedBox(
                  height: 10,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    setState(() {
      for (int i = 0; i < categories.length; i++) {
        widgets.add(
            ProductCategoryCard(categories[i], descriptions[i], logoPahts[i]));
      }
    });
  }
}
