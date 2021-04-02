import 'package:Toppick_App/Orders/Models/pedido.dart';
import 'package:Toppick_App/Products/Bloc/product_controller.dart';
import 'package:Toppick_App/Products/Models/combo.dart';
import 'package:Toppick_App/GeneralUserInterfaces/listmaintext.dart';
import 'package:Toppick_App/GeneralUserInterfaces/gradiant.dart';
import 'package:Toppick_App/GeneralUserInterfaces/header.dart';
import 'package:Toppick_App/Products/UserInterfaces/productcard.dart';
import 'package:Toppick_App/Products/UserInterfaces/home_combos_card.dart';
import 'package:Toppick_App/Products/UserInterfaces/productcategorycard.dart';
import 'package:Toppick_App/Products/UserInterfaces/productcategorydisplay.dart';
import 'package:Toppick_App/GeneralUserInterfaces/search_bar_button.dart';
import 'package:Toppick_App/Shops/Bloc/shop_controller.dart';
import 'package:flutter/material.dart';
import '../../Shops/Models/tienda.dart';
import 'package:Toppick_App/Products/UserInterfaces/home_product_card.dart';

class ProductList extends StatefulWidget {
  ProductList(this.current,this.store);
  final Tienda? store;
  final Pedido current;
  @override
  ProductListState createState() => ProductListState();
}

class ProductListState extends State<ProductList> {
  ProductListState();
  ProductController controller = ProductController();
  ShopController shopController = ShopController();
  List<String> categories = [];
  List<String> descriptions = [];
  List<String> logoPahts = [];
  List<ProductCategoryCard> widgets = [];
  /*Esta lista de productos se cargara con el ID de la tienda pasado al ProductList, si no le dan
  ese parametro se listan todos los productos.*/
  List<dynamic> productList = [];
  //Esta es la lista de tiendas donde se puede conseguir el producto
  List<Tienda> shopList = [];
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
            this.currentTitle = selectedCard.categoryName;
            this.currentDescription = selectedCard.categoryDescription;
            List<dynamic> selected =[];
            selected = controller.filterProducts(this.productList, this.currentTitle);
            this.products = ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: selected.length,
              itemBuilder: (BuildContext context, int index) {
                return GestureDetector(
                  onTap: () => {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          if(selected[index] is Combo){
                            return HomeCombosCard(
                                  selected[index], this.shopList, widget.store, widget.current);
                          }else{
                            return HomeProductCard(selected[index],
                                  this.shopList, widget.store, widget.current);
                          }
                        }
                      )
                    )
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(left: 15.0),
                    child: ProductCard(selected[index]),
                  ),
                );
              }
            );
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
                Header(widget.current),
                SearchButton("Buscar productos", 3),
                ListMainText("Escoge la", "comida que amas"),
                Padding(
                  padding: const EdgeInsets.only(top: 10.0, left: 10.0, bottom: 10.0),
                  child: Container(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Categorías",
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
                    itemCount: this.categories.length,
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
      this.categories = this.controller.getProductCategories();
      this.descriptions = this.controller.getCategoryDescription();
      this.logoPahts = this.controller.getCategoryImagePath();
      this.productList = this.controller.getAllAvailableProducts();
      this.shopList = this.shopController.getAllAvailableShops(); //Esta es la lista de tiendas donde se puede conseguir el producto
      for (int i = 0; i < this.categories.length; i++) {
        widgets.add(
            ProductCategoryCard(this.categories[i], this.descriptions[i], this.logoPahts[i]));
      }
    });
  }
}
