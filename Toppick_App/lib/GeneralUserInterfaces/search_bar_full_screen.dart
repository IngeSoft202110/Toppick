import 'package:Toppick_App/Orders/Models/pedido.dart';
import 'package:Toppick_App/Products/Bloc/product_controller.dart';
import 'package:Toppick_App/Products/Models/combo.dart';
import 'package:Toppick_App/Products/UserInterfaces/home_combos_card.dart';
import 'package:Toppick_App/Products/UserInterfaces/home_product_card.dart';
import 'package:Toppick_App/Shops/Bloc/shop_controller.dart';
import 'package:Toppick_App/Shops/Models/tienda.dart';
import 'package:Toppick_App/Shops/UserInterfaces/home_shop.dart';
import 'package:flutter/material.dart';

class SearchScreen extends StatefulWidget {
  SearchScreen(this.option, this.prefs, this.actual, {this.id=-1, this.hKey="", this.sName=""});
  final int option;
  final prefs;
  final Pedido actual;
  final int id; //Este id es -1 si se llama desde una pantalla que no sea el catalogo de productos un punto de venta
  final hKey; //Solo necesito la llave del estado cuando me llaman desde uno de los catalogos de productos o desde la pantalla inicial
  final String sName; //Este valor es "" si se llama desde una pantalla que no sea el catalogo de productos de un punto de venta
  @override
  _SearchScreenState createState() => _SearchScreenState(this.option);
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _filter = new TextEditingController();
  String _searchText = "";
  List names = [];
  List filteredNames = [];
  int option = 0;
  Widget _appBarTitle = new Text('');
  ShopController sController = ShopController();
  ProductController pController = ProductController();

  _SearchScreenState(int option) {
    this.option = option;
    _filter.addListener(() {
      if (_filter.text.isEmpty) {
        setState(() {
          _searchText = "";
          filteredNames = names;
        });
      } else {
        setState(() {
          _searchText = _filter.text;
        });
      }
    });
  }

  @override
  void initState() {
    this._getNames();
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(100), child: _buildBar(context)),
      body: Container(
        child: _buildList(),
      ),
    );
  }

  Widget _buildBar(BuildContext context) {
    this._appBarTitle = new TextField(
      controller: _filter,
      decoration: new InputDecoration(
        hintText: 'Buscar',
        hintStyle: TextStyle(color: Color(0xFFC4C4C4)),
      ),
    );
    return new AppBar(
      backgroundColor: Color(0xFFF3F3F3),
      centerTitle: true,
      title: _appBarTitle,
      leading: new IconButton(
        icon: new Icon(
          Icons.close,
          color: Colors.black,
        ),
        onPressed: _searchPressed,
      ),
    );
  }

  Widget _buildList() {
    // ignore: prefer_is_not_empty
    if (!(_searchText.isEmpty)) {
      List tempList = [];
      for (int i = 0; i < filteredNames.length; i++) {
        if (filteredNames[i]['name']
            .toLowerCase()
            .contains(_searchText.toLowerCase())) {
          tempList.add(filteredNames[i]);
        }
      }
      filteredNames = tempList;
    }
    return ListView.builder(
      itemCount: names.isEmpty ? 0 : filteredNames.length,
      itemBuilder: (BuildContext context, int index) {
        return new ListTile(
          title: Text(filteredNames[index]['name']),
          onTap: (){
            if(this.option==1){
              Navigator.of(context).pop();
              if(filteredNames[index]['store'] != null){
                Navigator.push(context, MaterialPageRoute(
                  builder: (context) => HomeShop(filteredNames[index]['store'], widget.actual, widget.prefs)));
              }else{
                if(filteredNames[index]['product'] is Combo){
                  Navigator.push(context, MaterialPageRoute(
                    builder: (context) => HomeCombosCard(filteredNames[index]['product'], Tienda(widget.id, widget.sName, "", "", "", "",""), widget.actual, widget.prefs, widget.hKey)));
                }else{
                  Navigator.push(context, MaterialPageRoute(
                    builder: (context) => HomeProductCard(filteredNames[index]['product'], Tienda(widget.id, widget.sName, "", "", "", "",""), widget.actual, widget.prefs, widget.hKey)));
                }
              }
            }else if(this.option==2){
              Navigator.of(context).pop();
              Navigator.push(context, MaterialPageRoute(
                  builder: (context) => HomeShop(filteredNames[index]['store'], widget.actual, widget.prefs)));
            }else{
              Navigator.of(context).pop();
              if(filteredNames[index]['product'] is Combo){
                Navigator.push(context, MaterialPageRoute(
                  builder: (context) => HomeCombosCard(filteredNames[index]['product'], Tienda(widget.id, widget.sName, "", "", "", "",""), widget.actual, widget.prefs, widget.hKey)));
              }else{
                Navigator.push(context, MaterialPageRoute(
                  builder: (context) => HomeProductCard(filteredNames[index]['product'], Tienda(widget.id, widget.sName, "", "", "", "",""), widget.actual, widget.prefs, widget.hKey)));
              }
            }
          },
        );
      },
    );
  }

  void _searchPressed() {
    setState(() {
      Navigator.pop(context);
    });
  }

  void _getNames() async {
    List a = [];
    if (this.option == 1) {
      this.sController.getAllAvailableShops(widget.prefs.getString('cookie')).then(
        (value){
          if(value.isNotEmpty){
            value.forEach((element) {
              a.add({"name":element.name, "store":element});
            });
          }
        }
      );
      this.pController.getAllAvailableProducts(widget.prefs.getString('cookie')).then(
        (value) {
          if(value.isNotEmpty){
            value.forEach((element) {
              a.add({"name":element.name, "product":element});
            });
          }
        }
      );
    } else if (this.option == 2) {
      this.sController.getAllAvailableShops(widget.prefs.getString('cookie')).then(
        (value){
          if(value.isNotEmpty){
            value.forEach((element) {
              a.add({"name":element.name, "store":element});
            });
          }
        }
      );
    } else {
      if(widget.id == -1){
        this.pController.getAllAvailableProducts(widget.prefs.getString('cookie')).then(
          (value) {
            if(value.isNotEmpty){
              value.forEach((element) {
                a.add({"name":element.name, "product":element});
              });
            }
          }
        );
      }else{
        this.pController.getProductCatalogueById(widget.id, widget.prefs.getString('cookie')).then(
          (value) {
            if(value.isNotEmpty){
              value.forEach((element) {
                a.add({"name":element.name, "product":element});
              });
            }
          }
        );
      }
      
    }

    List tempList = [];

    tempList = a;
    setState(() {
      names = tempList;
      names.shuffle();
      filteredNames = names;
    });
  }
}
