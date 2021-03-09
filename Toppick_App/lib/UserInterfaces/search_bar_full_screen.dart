import 'package:flutter/material.dart';

// ignore: must_be_immutable
class SearchScreen extends StatefulWidget {
  int option;
  SearchScreen(this.option);
  @override
  _SearchScreenState createState() => _SearchScreenState(this.option);
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _filter = new TextEditingController();
  String _searchText = "";
  List names = new List();
  List filteredNames = new List();
  int option;
  Widget _appBarTitle = new Text('');

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
      appBar: _buildBar(context),
      body: Container(
        child: _buildList(),
      ),
      resizeToAvoidBottomPadding: false,
    );
  }

  Widget _buildBar(BuildContext context) {
    this._appBarTitle = new TextField(
      controller: _filter,
      decoration: new InputDecoration(
        hintText: 'Buscar Tienda/Producto',
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
      List tempList = new List();
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
      itemCount: names == null ? 0 : filteredNames.length,
      itemBuilder: (BuildContext context, int index) {
        return new ListTile(
          title: Text(filteredNames[index]['name']),
          onTap: () => print(filteredNames[index]['name']),
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
    List a;
    if (this.option == 1) {
      a = [
        {"name": "pescadito"},
        {"name": "La central"},
        {"name": "ponque"},
      ];
    } else if (this.option == 2) {
      a = [
        {"name": "Pecera"},
        {"name": "La central"},
        {"name": "parqueaderos"},
      ];
    } else {
      a = [
        {"name": "pescadito"},
        {"name": "ponque"},
        {"name": "aguacate"},
        {"name": "Manzana"},
      ];
    }

    List tempList = new List();
    tempList = a;
    setState(() {
      names = tempList;
      names.shuffle();
      filteredNames = names;
    });
  }
}
