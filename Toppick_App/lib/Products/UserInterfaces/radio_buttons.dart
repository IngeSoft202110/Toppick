import 'package:flutter/material.dart';
import '../../Shops/Models/tienda.dart';
import '../Models/producto.dart';

class RadioButtonListStore extends StatelessWidget {
  RadioButtonListStore(this.selected, this.storeList, this.storeID, this.notifyParent);
  final Producto selected;
  final List<Tienda> storeList;
  final int storeID;
  final Function (Tienda? selectd) notifyParent;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Center(
        child: RadioButtonsStore(selected, storeList, this.storeID, this.notifyParent,)
      ),
    );
  }
}

class RadioButtonsStore extends StatefulWidget {
  RadioButtonsStore(this.selected, this.storeList, this.storeID, this.notifyParent);
  final Producto selected;
  final List<Tienda> storeList;
  final int storeID;
  final Function (Tienda? selectd) notifyParent;
  @override
  _RadioButtonsStoreState createState() =>
      _RadioButtonsStoreState(this.notifyParent);
}

class _RadioButtonsStoreState extends State<RadioButtonsStore> {
  _RadioButtonsStoreState(this.notifyParent);
  final Function (Tienda? selectd) notifyParent;
  Tienda? shopSelected;
  @override
  Widget build(BuildContext context) {
    List<Widget> aux = [];
    for (var store in widget.storeList) {
      var radio = ListTile(
        title: Text(store.name),
        leading: Radio<Tienda>(
          value: store,
          groupValue: shopSelected,
          onChanged: (Tienda? value) {
            setState(() {
              shopSelected = value;
              notifyParent(shopSelected);
            });
          },
        ),
      );
      aux.add(radio);
    }

    return Column(children: aux);
  }
}
