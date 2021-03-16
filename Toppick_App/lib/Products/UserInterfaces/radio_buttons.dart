import 'package:flutter/material.dart';
import '../../Shops/Models/tienda.dart';
import '../Models/producto.dart';

class RadioButtonListStore extends StatelessWidget {
  RadioButtonListStore(this.selected, this.storeList, this.storeID);
  final Producto selected;
  final List<Tienda> storeList;
  final int storeID;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Center(
        child: RadioButtonsStore(selected, storeList, this.storeID),
      ),
    );
  }
}

class RadioButtonsStore extends StatefulWidget {
  RadioButtonsStore(this.selected, this.storeList, this.storeID);
  final Producto selected;
  final List<Tienda> storeList;
  final int storeID;
  @override
  _RadioButtonsStoreState createState() =>
      _RadioButtonsStoreState((this.storeID==-1) ? this.storeList[0].id : this.storeID);
}

class _RadioButtonsStoreState extends State<RadioButtonsStore> {
  _RadioButtonsStoreState(this._optionSelected);
  int? _optionSelected;
  @override
  Widget build(BuildContext context) {
    print("${this._optionSelected}");
    List<Widget> aux = [];
    for (var store in widget.storeList) {
      var radio = ListTile(
        title: Text(store.name),
        leading: Radio<int>(
          value: store.id,
          groupValue: _optionSelected,
          onChanged: (int? value) {
            setState(() {
              _optionSelected = value;
              print(_optionSelected);
            });
          },
        ),
      );
      aux.add(radio);
    }

    return Column(children: aux);
  }
}
