import 'package:Toppick_App/Products/Models/a_la_carta.dart';
import 'package:Toppick_App/Products/Models/ingrediente.dart';
import 'package:flutter/material.dart';
import 'generic_button_for_modal.dart';
import 'checkbox.dart';

Widget listaCheck(Map<Ingrediente, bool> seleccionados) {
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

Widget obligatoryList(List<Ingrediente> obligatorios) {
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
            obligatorios[i].nombre,
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

Widget buttonsSection(BuildContext context, ALaCarta selected,
    Map<Ingrediente, bool> seleccionados) {
  return Container(
    margin: EdgeInsets.only(top: 10, left: 50, bottom: 10),
    child: Column(
      children: [
        GenericButton1(
            "Guardar", Color(0xFF00FF00), 90, 25, 10, 10, 10, 10, 20, 20, () {
          selected.selecciones = seleccionados;
          Navigator.pop(context);
        }),
        GenericButton1(
            "Volver", Color(0xFFFF0000), 90, 25, 10, 10, 10, 10, 20, 20, () {
          selected.selecciones.clear();
          Navigator.pop(context);
        }),
      ],
    ),
  );
}

// ignore: must_be_immutable
class ModalScreen extends StatelessWidget {
  ModalScreen(this.selected);
  final dynamic selected;
  Map<Ingrediente, bool> seleccionados = Map<Ingrediente, bool>();
  List<Ingrediente> obligatorios = [];
  List<Ingrediente> opcionales = [];

  List<Ingrediente> llenarDatosObligatorios(List<Ingrediente> ingredientes) {
    List<Ingrediente> obligatorios = [];
    for (var i = 0; i < ingredientes.length; i++) {
      if (ingredientes[i].obligatorio) obligatorios.add(ingredientes[i]);
    }
    return obligatorios;
  }

  List<Ingrediente> llenarDatosOpcionales(List<Ingrediente> ingredientes) {
    List<Ingrediente> obligatorios = [];
    for (var i = 0; i < ingredientes.length; i++) {
      if (!ingredientes[i].obligatorio) obligatorios.add(ingredientes[i]);
    }
    return obligatorios;
  }

  Map<Ingrediente, bool> llenarDatosModal(List<Ingrediente> ingredientes) {
    Map<Ingrediente, bool> mapa = Map<Ingrediente, bool>();
    for (var i = 0; i < ingredientes.length; i++) {
      mapa[ingredientes[i]] = false;
    }
    return mapa;
  }

  @override
  Widget build(BuildContext context) {
    this.obligatorios = llenarDatosObligatorios(this.selected.ingredientes);
    this.opcionales = llenarDatosOpcionales(this.selected.ingredientes);
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
                Center(child: title(this.selected.name)),
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
                buttonsSection(context, this.selected, this.seleccionados)
              ],
            )),
      ),
    );
  }
}
