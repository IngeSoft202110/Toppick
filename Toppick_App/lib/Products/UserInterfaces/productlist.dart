import 'package:Toppick_App/Orders/Models/pedido.dart';
import 'package:Toppick_App/Products/Bloc/product_controller.dart';
import 'package:Toppick_App/GeneralUserInterfaces/listmaintext.dart';
import 'package:Toppick_App/GeneralUserInterfaces/gradiant.dart';
import 'package:Toppick_App/GeneralUserInterfaces/header.dart';
import 'package:Toppick_App/Products/UserInterfaces/productcategorycard.dart';
import 'package:Toppick_App/Products/UserInterfaces/productcategorydisplay.dart';
import 'package:Toppick_App/GeneralUserInterfaces/search_bar_button.dart';
import 'package:Toppick_App/Shops/Bloc/shop_controller.dart';
import 'package:flutter/material.dart';
import '../../Shops/Models/tienda.dart';

class ProductList extends StatefulWidget {
  ProductList(this.current,this.store, this.productList, this.prefs);
  final Tienda? store;
  final Pedido current;
  final List<dynamic> productList;
  final prefs;
  final hKey = GlobalKey<HeaderState>(debugLabel: "KEY EN PRODUCT LIST");
  @override
  ProductListState createState() => ProductListState(this.productList);
}

class ProductListState extends State<ProductList> {
  ProductListState(this.productList);
  ProductController controller = ProductController();
  ShopController shopController = ShopController();
  List<String> categories = [];
  List<String> descriptions = [];
  List<String> logoPahts = [];
  List<ProductCategoryCard> widgets = [];
  /*Esta lista de productos se cargara con el ID de la tienda pasado al ProductList, si no le dan
  ese parametro se listan todos los productos.*/
  List<dynamic> productList;
  List<dynamic> filtered = [];
  //Esta es la lista de tiendas donde se puede conseguir el producto
  String currentTitle = "";
  String currentDescription = "";
  String currentLogoCategory = "";

  Widget selectProductsFromCategory(BuildContext context, int index) {
    return Padding(
      padding: const EdgeInsets.only(left: 15.0, bottom: 25.0),
      child: GestureDetector(
        onTap: () {
          setState(() {
            ProductCategoryCard selectedCard = widgets[index];
            this.currentTitle = selectedCard.categoryName;
            this.currentDescription = selectedCard.categoryDescription;
            this.currentLogoCategory = selectedCard.categoryLogoPath;
            this.filtered = controller.filterProducts(this.productList, this.currentTitle);
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
                Header(widget.current, widget.prefs, hKey: widget.hKey, showCart: true,),
                SearchButton("Buscar productos", 3, widget.prefs, widget.current, hKey: widget.hKey, id: widget.store!.id, sName: widget.store!.name,),
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
                ProductCategoryDisplay(this.currentTitle, this.currentDescription, this.currentLogoCategory, this.filtered, widget.store!, widget.current, widget.prefs, widget.hKey),
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
  void initState(){
    super.initState();
    setState((){
      this.categories = this.controller.getProductCategories();
      this.descriptions = this.controller.getCategoryDescription();
      this.logoPahts = this.controller.getCategoryImagePath();
      
      for (int i = 0; i < this.categories.length; i++) {
        widgets.add(ProductCategoryCard(this.categories[i], this.descriptions[i], this.logoPahts[i]));
      }
    });
  }
}
