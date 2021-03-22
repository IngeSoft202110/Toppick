import 'package:flutter/material.dart';

class CheckboxRow extends StatefulWidget {
  CheckboxRow(this.seleccionados, this.name);
  final Map<String, bool> seleccionados;
  final String name;
  @override
  _CheckboxRowState createState() =>
      _CheckboxRowState(this.seleccionados, this.name);
}

class _CheckboxRowState extends State<CheckboxRow> {
  _CheckboxRowState(this.seleccionados, this.name);
  final Map<String, bool> seleccionados;
  final String name;
  bool rememberMe = false;
  void _onRememberMeChanged() => setState(() {
        rememberMe = !rememberMe;
        print("antes del check: ${this.seleccionados[this.name]} \n");
        this.seleccionados[this.name] = rememberMe;
        print("despues del check: ${this.seleccionados[this.name]} \n");
      });

  @override
  Widget build(BuildContext context) {
    rememberMe = seleccionados[name]!;
    return Container(
      margin: EdgeInsets.only(top: 10.0, left: 40.0),
      child: Row(
        children: [
          Text(this.name,
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF9C9C9C))),
          Checkbox(value: rememberMe, onChanged: _onRememberMeChanged)
        ],
      ),
    );
  }
}
