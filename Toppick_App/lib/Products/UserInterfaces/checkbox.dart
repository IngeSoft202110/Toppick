import 'package:Toppick_App/Products/Models/ingrediente.dart';
import 'package:flutter/material.dart';

class CheckboxRow extends StatefulWidget {
  CheckboxRow(this.seleccionados, this.name);
  final Map<Ingrediente, bool> seleccionados;
  final Ingrediente name;
  @override
  _CheckboxRowState createState() =>
      _CheckboxRowState(this.seleccionados, this.name);
}

class _CheckboxRowState extends State<CheckboxRow> {
  _CheckboxRowState(this.seleccionados, this.name);
  final Map<Ingrediente, bool> seleccionados;
  final Ingrediente name;
  bool rememberMe = false;
  @override
  Widget build(BuildContext context) {
    rememberMe = seleccionados[name]!;
    return Container(
      margin: EdgeInsets.only(top: 10.0, left: 40.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(this.name.nombre,
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF9C9C9C))),
          Checkbox(
            value: rememberMe,
            onChanged: (bool? value) {
              setState(() {
                if (value != null) rememberMe = value;
                print("antes del check: ${this.seleccionados[this.name]} \n");
                this.seleccionados[this.name] = rememberMe;
                print("despues del check: ${this.seleccionados[this.name]} \n");
              });
            },
          )
        ],
      ),
    );
  }
}
