import 'package:flutter/material.dart';
import '../../Shops/Models/tienda.dart';
import '../Models/producto.dart';

class RadioButtonListStore extends StatelessWidget {
  RadioButtonListStore(this.selected, this.storeList);
  final Producto selected;
  final List<Tienda> storeList;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Center(
        child: RadioButtonsStore(selected, storeList),
      ),
    );
  }
}

class RadioButtonsStore extends StatefulWidget {
  RadioButtonsStore(this.selected, this.storeList);
  final Producto selected;
  final List<Tienda> storeList;
  @override
  _RadioButtonsStoreState createState() =>
      _RadioButtonsStoreState(storeList[0].id);
}

class _RadioButtonsStoreState extends State<RadioButtonsStore> {
  _RadioButtonsStoreState(this._optionSelected);
  int? _optionSelected;
  @override
  Widget build(BuildContext context) {
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
