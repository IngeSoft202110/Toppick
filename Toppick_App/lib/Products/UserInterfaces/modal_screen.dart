import 'package:flutter/material.dart';
import 'generic_button_for_modal.dart';
import 'checkbox.dart';

Widget listaCheck(Map<String, bool> seleccionados) {
  List<Widget> aux = [];
  seleccionados.forEach((key, value) {
    aux.add(CheckboxRow(seleccionados, key));
  });
  return Column(
    children: aux,
  );
}

Widget title(String name) {
  return Container(
    child: Column(
      children: [
        Text(
          "Personaliza tu",
          style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 35,
              color: Color(0xFFD76060)),
        ),
        Text(
          name,
          style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 28,
              color: Color(0xFFD76060)),
        )
      ],
    ),
  );
}

Widget obligatoryList(List<String> obligatorios) {
  List<Widget> aux = [];
  for (var i = 0; i < obligatorios.length; i++) {
    aux.add(Container(
      margin: EdgeInsets.only(top: 15.0, left: 5),
      child: Row(
        children: [
          Icon(
            Icons.arrow_right,
            color: Color(0xFF9C9C9C),
          ),
          Text(
            obligatorios[i],
            style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color(0xFF9C9C9C)),
          ),
        ],
      ),
    ));
  }
  return Container(
    margin: EdgeInsets.only(top: 12.0, left: 18.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Obligatorios",
          style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 20,
              color: Color(0xFFD76060)),
        ),
        Column(
          children: aux,
        )
      ],
    ),
  );
}

Widget buttonsSection(BuildContext context) {
  return Container(
    margin: EdgeInsets.only(top: 10, left: 50, bottom: 10),
    child: Row(
      children: [
        GenericButton1(
            "Guardar", Color(0xFF00FF00), 90, 25, 10, 10, 10, 10, 20, 20, () {
          Navigator.pop(context);
        }),
        GenericButton1(
            "Volver", Color(0xFFFF0000), 90, 25, 10, 10, 10, 10, 20, 20, () {
          Navigator.pop(context);
        }),
      ],
    ),
  );
}

// ignore: must_be_immutable
class ModalScreen extends StatelessWidget {
  ModalScreen(this.name);
  final String name;
  Map<String, bool> seleccionados = Map<String, bool>();
  List<String> obligatorios = [];
  List<String> opcionales = [];

  List<String> llenarDatosObligatorios() {
    List<String> obligatorios = [];
    for (var i = 0; i < 3; i++) {
      obligatorios.add("obligatorio" + i.toString());
    }
    return obligatorios;
  }

  List<String> llenarDatosOpcionales() {
    List<String> obligatorios = [];
    for (var i = 0; i < 10; i++) {
      obligatorios.add("opcional" + i.toString());
    }
    return obligatorios;
  }

  Map<String, bool> llenarDatosModal(List<String> ingredientes) {
    Map<String, bool> mapa = Map<String, bool>();
    for (var i = 0; i < ingredientes.length; i++) {
      //if(ingredientes[i].tipo == opcional)
      mapa[ingredientes[i]] = false;
    }
    return mapa;
  }

  @override
  Widget build(BuildContext context) {
    this.obligatorios = llenarDatosObligatorios();
    this.opcionales = llenarDatosOpcionales();
    this.seleccionados = llenarDatosModal(this.opcionales);
    return Material(
      color: Color(0xFFFFFEEE),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(32)),
      child: SingleChildScrollView(
        child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(child: title(this.name)),
                obligatoryList(this.obligatorios),
                Container(
                  margin: EdgeInsets.only(top: 12.0, left: 18.0),
                  child: Text(
                    "Personalizables",
                    style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 20,
                        color: Color(0xFFD76060)),
                  ),
                ),
                listaCheck(this.seleccionados),
                buttonsSection(context)
              ],
            )),
      ),
    );
  }
}
