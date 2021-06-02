import 'package:flutter/material.dart';
import '../Models/producto.dart';
import 'package:intl/intl.dart';

class AddSubstract extends StatefulWidget {
  AddSubstract(this.selected, this.notifyParent);
  final Producto selected;
  final Function(String type) notifyParent;
  @override
  _AddSubstractState createState() =>
      _AddSubstractState(this.selected.price, this.selected.price, this.notifyParent);
}

class _AddSubstractState extends State<AddSubstract> {
  _AddSubstractState(this._defaultValue, this._price, this.notifyParent);
  int _units = 1;
  int _defaultValue;
  int _price;
  final Function(String type) notifyParent;
  @override
  Widget build(BuildContext context) {
    var formatter = NumberFormat('#,###,000');
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "\$${formatter.format(_price)}",
          style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 30,
              color: Color(0xFFB7B7B7)),
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
                        this._price = this._defaultValue;
                      }else{
                        this._units -= 1;
                        this._price -= this._defaultValue;
                        notifyParent("Substract");
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
                      notifyParent("Add");
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
