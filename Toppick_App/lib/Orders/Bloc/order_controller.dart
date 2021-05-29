import 'package:Toppick_App/Products/Models/producto.dart';
import 'package:Toppick_App/Shops/Models/tienda.dart';

import '../Models/pedido.dart';
import '../Repositories/orders_queries.dart';
import 'package:flutter/material.dart';

class OrderController {
  OrdersQueries orderqueries = new OrdersQueries();
  
  OrderController() {
    this.orderqueries = new OrdersQueries();
  }

  Future<List<Pedido>> getOrderHistory(String cookie) {
    return this.orderqueries.getOrderHistory(cookie);
  }

  Future<List<Pedido>> getActiveOrders(String cookie) {
    return this.orderqueries.getActiveOrders(cookie);
  }
  
  void sendOrder(Pedido pedido){
    this.orderqueries.funcionDatos(pedido);
  }

  DateTime getMaxShopsHour(Pedido currentP, int day){
    if(currentP.carrito.isNotEmpty){
      DateTime current = DateTime.now();
      Iterable<Tienda?> shops = currentP.carrito.keys;
      String dayString = getDayName(day);
      TimeOfDay? result =  shops.first!.getScheduleEndHour(dayString);
      DateTime resultD = DateTime(current.year, current.month, current.day, result!.hour, result.minute);
      for(int i = 0; i < shops.length; i++){
        TimeOfDay? actual = shops.elementAt(i)!.getScheduleEndHour(dayString);
        DateTime actualD = DateTime(current.year, current.month, current.day, actual!.hour, actual.minute);
        if(actualD.isBefore(resultD)){
          resultD = DateTime(current.year, current.month, current.day, actual.hour, actual.minute);
        }
      }
      return resultD;
    }
    return DateTime.now();
  }

  DateTime getMinShopsHour(Pedido currentP, int day){
    if(currentP.carrito.isNotEmpty){
      DateTime current = DateTime.now();
      Iterable<Tienda?> shops = currentP.carrito.keys;
      String dayString = getDayName(day);
      TimeOfDay? result =  shops.first!.getScheduleStartHour(dayString);
      DateTime resultD = DateTime(current.year, current.month, current.day, result!.hour, result.minute);
      for(int i = 0; i < shops.length; i++){
        TimeOfDay? actual = shops.elementAt(i)!.getScheduleStartHour(dayString);
        DateTime actualD = DateTime(current.year, current.month, current.day, actual!.hour, actual.minute);
        if(actualD.isAfter(resultD)){
          resultD = DateTime(current.year, current.month, current.day, actual.hour, actual.minute);
        }
      }
      return resultD;
    }
    return DateTime.now();
  }

  String getDayName(int day){
    String result = "";
    if(day==1){
      result="Lunes";
    }
    else if(day==2){
      result="Martes";
    }
    else if(day==3){
      result="Miércoles";
    }
    else if(day==4){
      result="Jueves";
    }
    else if(day==5){
      result="Viernes";
    }
    else if(day==6){
      result="Sábado";
    }
    else if(day==7){
      result="Domingo";
    }
    return result;
  }

  bool isAfterThan(DateTime first, DateTime second){
    return first.isAfter(second);
  }

  bool isBeforeThan(DateTime first, DateTime second){
    return first.isBefore(second);
  }

  DateTime maxProductTime(Pedido current){
    DateTime result = DateTime.now();
    double minTime = 0;
    current.carrito.forEach((key, value) {
      value.forEach((key, value) {
        double current = key.preparationTime.toDouble();
        if(current >= minTime){
          minTime = current;
        }
      });
    });
    double hours = minTime/60;
    double newTime = minTime;
    if(minTime > 60){
      newTime = minTime - (hours.toInt()*60);
    }
    result = generateHour(hours.toInt(), newTime.toInt());
    return result;
  }

  DateTime generateHour(int plusHours, int plusMinutes){
    return DateTime.now().add(Duration(hours: plusHours, minutes: plusMinutes));
  }

  cancelOrderWarning(BuildContext context, Pedido current, var key){
    Widget yesButton = TextButton(
      child: Text("Si"),
      onPressed: () { key.currentState!.recalculate(0, true);current.carrito.clear(); Navigator.of(context).pop(); Navigator.of(context).pop();},
    );
    Widget noButton = TextButton(
      child: Text("No"),
      onPressed: () { Navigator.of(context).pop();},
    );
    AlertDialog alert = AlertDialog(
      title: Text("Cancelar pedido", style: TextStyle(color: Color(0xFFD76060)),),
      content: Text("¿Está seguro de querer borrar el pedido"),
      actions: [
        yesButton,
        noButton,
      ],
    );
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  showPayMethodWarning(BuildContext context){
    Widget okButton = TextButton(
      child: Text("OK"),
      onPressed: () { Navigator.of(context).pop();},
    );
    AlertDialog alert = AlertDialog(
      title: Text("No se ha seleccionado un método de pago", style: TextStyle(color: Color(0xFFD76060)),),
      content: Text("Por favor seleccione alguno de sus métodos de pago para poder realizar el pedido."),
      actions: [
        okButton,
      ],
    );
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  showPayHourWarning(BuildContext context){
    Widget okButton = TextButton(
      child: Text("OK"),
      onPressed: () { Navigator.of(context).pop();},
    );
    AlertDialog alert = AlertDialog(
      title: Text("No se ha seleccionado una hora válida", style: TextStyle(color: Color(0xFFD76060)),),
      content: Text("Por favor seleccione una hora válida para poder pasar por el pedido."),
      actions: [
        okButton,
      ],
    );
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  showEmptyOrder(BuildContext context){
    Widget okButton = TextButton(
      child: Text("OK"),
      onPressed: () {Navigator.of(context).pop(); Navigator.of(context).pop();},
    );
    AlertDialog alert = AlertDialog(
      title: Text("Pedido vacío", style: TextStyle(color: Color(0xFFD76060)),),
      content: Text("No quedan más productos en el pedido, por favor agregue productos al pedido."),
      actions: [
        okButton,
      ],
    );
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  showMinTimeWarning(BuildContext context){
    Widget okButton = TextButton(
      child: Text("OK"),
      onPressed: () {Navigator.of(context).pop();},
    );
    AlertDialog alert = AlertDialog(
      title: Text("Tiempo mínimo invalido", style: TextStyle(color: Color(0xFFD76060)),),
      content: Text("El tiempo mínimo para recoger el pedido no es válido, elimine los productos que generan conflicto e intente de nuevo."),
      actions: [
        okButton,
      ],
    );
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  int changeQuantity(int value, String operationType, Producto selected, Tienda currentShop, int total, Pedido actual, BuildContext context, var hKey){
    if(operationType == "Sum"){
      total+=value;
      int newQuantity = actual.carrito[currentShop]![selected]!+1;
      actual.carrito[currentShop]![selected] = newQuantity;
      hKey.currentState!.recalculate(1, false);
    }else if(operationType == "Substract"){
      total-=value;
      int newQuantity = actual.carrito[currentShop]![selected]!-1;
      actual.carrito[currentShop]![selected] = newQuantity;
      hKey.currentState!.recalculate(-1, false);
    }else if(operationType == "Delete"){
      actual.carrito[currentShop]!.remove(selected);
      hKey.currentState!.recalculate(-1, false);
      if(actual.carrito[currentShop]!.isEmpty){
        actual.carrito.remove(currentShop);
      }
      total-=value;
    }
    return total;
  }

  bool isOutOfRange(DateTime selectedHour, DateTime maxShopTime, DateTime minShopTime) {
    print("${selectedHour.isAfter(maxShopTime)}");
    print("${selectedHour.isBefore(minShopTime)}");
    return selectedHour.isAfter(maxShopTime) && selectedHour.isBefore(minShopTime);
  }

}
