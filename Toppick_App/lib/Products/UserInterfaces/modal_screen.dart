import 'package:Toppick_App/Products/Models/acompanamiento.dart';
import 'package:Toppick_App/Products/Models/especialidad.dart';
import 'package:flutter/material.dart';
import 'generic_button_for_modal.dart';
import 'checkbox.dart';

Widget listaCheck(Map<Acompanamiento, bool> seleccionados) {
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
        Padding(
          padding: const EdgeInsets.only(left: 10.0, right: 10.0),
          child: Text(
            name,
            style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 28,
                color: Color(0xFFD76060)),
          ),
        )
      ],
    ),
  );
}

Widget buttonsSection(BuildContext context, Especialidad selected,
    Map<Acompanamiento, bool> seleccionados) {
  return Container(
    margin: EdgeInsets.only(top: 10, left: 50, bottom: 10),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        GenericButton1(
            "Guardar", Color(0xFF0CC665), 90, 25, 10, 10, 10, 10, 20, 20, () {
          selected.selecciones = seleccionados;
          Navigator.pop(context);
        }),
        GenericButton1(
            "Volver", Color(0xFFFB2900), 90, 25, 10, 10, 10, 10, 20, 20, () {
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
  Map<Acompanamiento, bool> seleccionados = Map<Acompanamiento, bool>();
  List<Acompanamiento> opcionales = [];

  Map<Acompanamiento, bool> llenarDatosModal(List<Acompanamiento> ingredientes) {
    Map<Acompanamiento, bool> mapa = Map<Acompanamiento, bool>();
    for (var i = 0; i < ingredientes.length; i++) {
      mapa[ingredientes[i]] = false;
    }
    return mapa;
  }

  @override
  Widget build(BuildContext context) {
    this.opcionales = this.selected.acompanamientos;
    this.seleccionados = llenarDatosModal(this.opcionales);
    return Row(
      children: [
        Expanded(
          flex: 2,
          child: Material(
            color: Color(0xFFFFFEEE),
            elevation: 2,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(32)),
            child: SingleChildScrollView(
              child: Padding(
                  padding: const EdgeInsets.all(0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(child: title(this.selected.name)),
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
                      Center(
                        child: GenericButton1("Guardar", Color(0xFF0CC665), 100,
                            32, 10, 10, 10, 10, 20, 20, () {
                          selected.selecciones = seleccionados;
                          Navigator.pop(context);
                        }),
                      ),
                      Center(
                        child: GenericButton1("Volver", Color(0xFFFB2900), 100,
                            32, 10, 10, 10, 10, 20, 20, () {
                          selected.selecciones.clear();
                          Navigator.pop(context);
                        }),
                      ),
                    ],
                  )),
            ),
          ),
        ),
      ],
    );
  }
}
