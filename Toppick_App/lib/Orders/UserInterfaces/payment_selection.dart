import 'package:Toppick_App/Orders/Models/metodopago.dart';
import 'package:flutter/material.dart';


class RadioButtonPaymentList extends StatelessWidget {
  RadioButtonPaymentList(this.paymentList, this.notifyParent);
  final List<dynamic> paymentList;
  final Function(MetodoPago? selected) notifyParent;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Center(
        child: RadioButtonsStore(this.paymentList, this.notifyParent),
      ),
    );
  }
}

class RadioButtonsStore extends StatefulWidget {
  RadioButtonsStore(this.paymentList, this.notifyParent);
  final List<dynamic> paymentList;
  final Function(MetodoPago? selected) notifyParent; 
  @override
  _RadioButtonsStoreState createState() =>
      _RadioButtonsStoreState();
}

class _RadioButtonsStoreState extends State<RadioButtonsStore> {
  _RadioButtonsStoreState();
  MetodoPago? _optionSelected;
  @override
  Widget build(BuildContext context) {
    List<Widget> aux = [];
    for (var method in widget.paymentList) {
      var radio = ListTile(
        title: Text(method.runtimeType.toString()),
        leading: Radio<MetodoPago>(
          value: method,
          groupValue:_optionSelected,
          onChanged: (MetodoPago? value) {
            setState(() {
              _optionSelected = value;
              widget.notifyParent(_optionSelected);
            });
          },
        ),
      );
      aux.add(radio);
    }

    return Column(children: aux);
  }
}
