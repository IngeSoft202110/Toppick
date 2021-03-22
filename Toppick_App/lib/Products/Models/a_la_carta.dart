import 'package:Toppick_App/Products/Models/ingrediente.dart';
import 'package:Toppick_App/Products/Models/producto.dart';

class ALaCarta extends Producto {
  DateTime horaInicioDisponibilidad, horaFinDisponibilidad;
  List<Ingrediente> ingredientes;
  Map<Ingrediente, bool> selecciones = new Map<Ingrediente, bool>();
  ALaCarta(
      this.horaInicioDisponibilidad,
      this.horaFinDisponibilidad,
      this.ingredientes,
      id,
      String name,
      int price,
      String description,
      int preparationTime,
      double score,
      String category)
      : super(id, name, price, description, preparationTime, score, category);
}
