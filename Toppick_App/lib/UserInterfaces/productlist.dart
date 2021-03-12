import 'package:Toppick_App/UserInterfaces/backarrowbutton.dart';
import 'package:Toppick_App/UserInterfaces/listmaintext.dart';
import 'package:Toppick_App/UserInterfaces/gradiant.dart';
import 'package:Toppick_App/UserInterfaces/header.dart';
import 'package:Toppick_App/UserInterfaces/productcard.dart';
import 'package:Toppick_App/UserInterfaces/productcategorycard.dart';
import 'package:Toppick_App/UserInterfaces/productcategorydisplay.dart';
import 'package:flutter/material.dart';

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

class Producto{
  String name;
  String description;
  String category;
  int price;
  Producto(this.name, this.description, this.category, this.price);
}

/*Esta lista de productos se cargara con el ID de la tienda pasado al ProductList, si no le dan
ese parametro se listan todos los productos.*/
List <Producto> productList = [
  Producto("Pescadito", "Hojaldre relleno de arequipe, preparado por los mejores cocineros de toda la universidad.", "Horneados", 3000),
  Producto("Hamburguesa", "Rica hamburguesa de la PUJ, preparada con la mejor carne y vegetales de Colombia.", "A la carta", 10000),
  Producto("Te", "Te frio de la PUJ, perfecto para combinar con otras comidas que ofrece la universidad.", "Bebidas", 2000),
  Producto("Avena", "Avena alpina como la conoces, simple pero muy rica.", "Bebidas", 1200),
  Producto("Chocorramo", "Ponque de vainilla recubierto en chocolate", "Empaquetados", 2000),
  Producto("Combo del mes", "Pescadito con Te", "Combos", 5000),
];

List<Producto> filterProducts(List<Producto> products, String category){
  List<Producto> filtered = [];
  for(Producto product in products){
    if(product.category == category)
      filtered.add(product);
  }
  return filtered;
}


class ProductList extends StatefulWidget {
  ProductList({this.storeID});
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Gradiant(),
          Column(
            children: <Widget>[
              Header(),
              BackButtonArrow(),
              SizedBox(
                height: 500,
                child: ListView(
                  children: <Widget>[
                    ListMainText("Escoge la", "comida que amas"),
                    Padding(
                      padding: const EdgeInsets.only(top:10.0, left: 10.0, bottom: 10.0),
                      child: Container(
                        alignment: Alignment.centerLeft,
                        child: Text("Categorias", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white, fontSize: 25),),
                      ),
                    ),
                    SizedBox(
                      height: 150,
                      child: ListView.builder(
                        itemCount: categories.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (BuildContext context, int index){
                          return Padding(
                            padding: const EdgeInsets.only(left: 15.0, bottom: 25.0),
                            child: GestureDetector(
                              onTap: (){
                                setState(() {
                                  ProductCategoryCard selectedCard = widgets[index];
                                  if(selectedCard!=null){
                                    this.currentTitle = selectedCard.categoryName;
                                    this.currentDescription = selectedCard.categoryDescription;
                                    List<Producto> selected = filterProducts(productList, this.currentTitle);
                                    this.products = ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      itemCount: selected.length,
                                      itemBuilder: (BuildContext context, int index){
                                        return Padding(
                                          padding: const EdgeInsets.only(left:15.0),
                                          child: ProductCard(selected[index]),
                                        );
                                      }
                                    );
                                  }
                                });
                              },
                              child: widgets[index],
                            ),
                          );
                        }
                      ),
                    ),
                    ProductCategoryDisplay(this.currentTitle, this.currentDescription, this.products),
                  ],
                ),
              ),
            ]
          )
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    setState(() {
      for(int i = 0; i < categories.length; i++){
        widgets.add(ProductCategoryCard(categories[i], descriptions[i], logoPahts[i]));
      }
    });
  }
}