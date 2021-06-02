import 'package:Toppick_App/Products/Models/producto.dart';
import 'package:Toppick_App/Shops/Models/tienda.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';


class AddSubstract extends StatefulWidget {
  AddSubstract(this.selected,this.currentShop, this.quantity, this.notifyParent);
  final Producto selected;
  final Tienda currentShop;
  final int quantity;
  final Function(int value, String operationType, Producto selected, Tienda currentStore) notifyParent;
  @override
  _AddSubstractState createState() => _AddSubstractState(this.selected.price, this.notifyParent, this.quantity);
}

class _AddSubstractState extends State<AddSubstract> {
  _AddSubstractState(this._defaultValue, this.notifyParent, this._units);
  int _units;
  int _defaultValue;
  int _price = 0;

  @override
  void initState() {
    _price = widget.selected.price * widget.quantity;
    super.initState();
  }

  final Function(int value, String operationType, Producto selected, Tienda currentStore) notifyParent;
  @override
  Widget build(BuildContext context) {
    var formatter = NumberFormat('#,###,000');
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding: const EdgeInsets.only(right: 8.0),
          child: Text(
            "\$${formatter.format(_price)}",
            style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 20,
                color: Color(0xFFB7B7B7)),
          ),
        ),
        Container(
          width: 140,
          height: 25,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(7)),
          child: Row(
            children: [
              Container(
                child: InkWell(
                  onTap: () {
                    setState(() {
                      if(this._units == 1){
                        this._units = 1;
                        this._price -= this._defaultValue;
                        this.notifyParent(this._defaultValue, "Delete", widget.selected, widget.currentShop);
                      }else{
                        this._units -= 1;
                        this._price -= this._defaultValue;
                        this.notifyParent(this._defaultValue, "Substract", widget.selected, widget.currentShop);
                      }    
                    });
                  },
                  child: Container(
                    width: 25,
                    height: 25,
                    decoration: BoxDecoration(
                        color: Color(0xFFFF441F),
                        borderRadius: BorderRadius.circular(5.0),
                        border: Border.all(
                            width: 1.0, color: const Color(0xFF000000))),
                    child: Center(
                      child: Icon(
                        Icons.horizontal_rule_rounded,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                  height: 25,
                  width: 40,
                  color: Colors.white,
                  margin: EdgeInsets.only(left: 5, right: 5),
                  child: Center(
                      child: Text(
                    "$_units",
                    style: TextStyle(fontSize: 20),
                  ))),
              Container(
                child: InkWell(
                  onTap: () {
                    setState(() {
                      this._units += 1;
                      this._price += this._defaultValue;
                      this.notifyParent(this._defaultValue, "Sum", widget.selected, widget.currentShop);
                    });
                  },
                  child: Container(
                    width: 25,
                    height: 25,
                    decoration: BoxDecoration(
                        color: Color(0xFFFF441F),
                        borderRadius: BorderRadius.circular(5.0),
                        border: Border.all(
                            width: 1.0, color: const Color(0xFF000000))),
                    child: Center(
                      child: Icon(
                        Icons.add_outlined,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}