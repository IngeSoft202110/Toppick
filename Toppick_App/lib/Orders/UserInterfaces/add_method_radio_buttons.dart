import 'package:Toppick_App/Orders/Models/daviplata.dart';
import 'package:Toppick_App/Orders/Models/nequi.dart';
import 'package:Toppick_App/Orders/Models/pse.dart';
import 'package:flutter/material.dart';

class RadioButtonListMethods extends StatelessWidget {
  RadioButtonListMethods(this.methods, this.notifyParent);
  final List<dynamic> methods;
  final Function(String) notifyParent;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 40),
      width: double.infinity,
      child: Center(
        child: RadioButtonsMethod(this.methods, this.notifyParent),
      ),
    );
  }
}

class RadioButtonsMethod extends StatefulWidget {
  RadioButtonsMethod(this.methods, this.notifyParent);
  final List<dynamic> methods;
  final Function(String) notifyParent;
  @override
  _RadioButtonsMethodState createState() => _RadioButtonsMethodState();
}

class _RadioButtonsMethodState extends State<RadioButtonsMethod> {
  String selected = "";
  List<Widget> fill(){
    List<Widget> result = [];
    bool dv = false;
    bool nq = false;
    bool pse = false;
    for(var method in widget.methods){
      if(method is DaviPlata){
        dv = true;
      }else if(method is Nequi){
        nq = true;
      }
      else if(method is PSE){
        pse = true;
      }
    }
    if(!dv){
      result.add(
        ListTile(
          title: Text("Daviplata", style: TextStyle(color: Colors.white),),
          leading: Radio<String>(
            value: "Daviplata",
            groupValue: selected,
            activeColor: Colors.white,
            onChanged: (String? value){
              setState(() {
                selected = value!;
                widget.notifyParent(selected);
              });
            },
          ),
        )
      );
    }
    if(!nq){
      result.add(
        ListTile(
          title: Text("Nequi", style: TextStyle(color: Colors.white),),
          leading: Radio<String>(
            value: "Nequi",
            groupValue: selected,
            activeColor: Colors.white,
            onChanged: (String? value){
              setState(() {
                selected = value!;
                widget.notifyParent(selected);
              });
            },
          ),
        )
      );
    }
    if(!pse){
      result.add(
        ListTile(
          title: Text("PSE", style: TextStyle(color: Colors.white),),
          leading: Radio<String>(
            value: "PSE",
            groupValue: selected,
            activeColor: Colors.white,
            onChanged: (String? value){
              setState(() {
                selected = value!;
                widget.notifyParent(selected);
              });
            },
          ),
        )
      );
    }
    return result;
  }
  @override
  Widget build(BuildContext context) {
    return Column(children: fill());
  }
}