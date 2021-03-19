import 'package:Toppick_App/Products/Models/producto.dart';
import 'package:flutter/material.dart';


class AddSubstract extends StatefulWidget {
  AddSubstract(this.selected, this.quantity, this.notifyParent);
  final Producto selected;
  final int quantity;
  final Function(int value, String operationType) notifyParent;
  @override
  _AddSubstractState createState() => _AddSubstractState(this.selected.price, this.selected.price, this.notifyParent, this.quantity);
}

class _AddSubstractState extends State<AddSubstract> {
  _AddSubstractState(this._defaultValue, this._price, this.notifyParent, this._units);
  int _units;
  int _defaultValue;
  int _price;
  final Function(int value, String operationType) notifyParent;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "\$$_price",
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
                        this.notifyParent(this._defaultValue, "Substract");
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
                      this.notifyParent(this._defaultValue, "Sum");
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