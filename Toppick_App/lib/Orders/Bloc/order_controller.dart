import 'package:Toppick_App/Products/Models/producto.dart';
import 'package:Toppick_App/Shops/Models/horario.dart';
import 'package:Toppick_App/Shops/Models/tienda.dart';

import '../Models/pedido.dart';
import '../Repositories/orders_queries.dart';
import 'package:flutter/material.dart';

class OrderController {
  OrdersQueries orderqueries = new OrdersQueries();
  
  OrderController() {
    this.orderqueries = new OrdersQueries();
  }

  List<Pedido> getFavoriteOrders() {
    return this.orderqueries.getFavoriteOrders();
  }

  List<Pedido> getOrderHistory() {
    return this.orderqueries.getOrderHistory();
  }

  Pedido getOrderStatusResponse() {
    return this.orderqueries.getOrderStatusResponse();
  }

  bool postOrder(Pedido order) {
    return this.orderqueries.postOrder(order);
  }

  TimeOfDay getMaxShopsHour(Pedido current, int day){
    Iterable<Tienda?> shops = current.carrito.keys;
    String dayString = getDayName(day);
    TimeOfDay? result =  shops.first!.getScheduleEndHour(dayString);
    for(int i = 0; i < shops.length; i++){
      TimeOfDay? actual = shops.elementAt(i)!.getScheduleEndHour(dayString);
      if(actual!.hour <= result!.hour && actual.minute >= result.minute){
        result = actual;
      }
    }
    return result!;
  }

  TimeOfDay getMinShopsHour(Pedido current, int day){
    Iterable<Tienda?> shops = current.carrito.keys;
    String dayString = getDayName(day);
    TimeOfDay? result =  shops.first!.getScheduleStartHour(dayString);
    for(int i = 0; i < shops.length; i++){
      TimeOfDay? actual = shops.elementAt(i)!.getScheduleStartHour(dayString);
      if(actual!.hour >= result!.hour && actual.minute <= result.minute){
        result = actual;
      }
    }
    return result!;
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

  bool timeGreaterOrEqualThanX(TimeOfDay first, TimeOfDay second){
    bool result = false;
    if(first.hour > second.hour){
      result = true;
    }
    else if(first.hour == second.hour){
      if(first.minute > second.minute){
        result = true;
      }
      else if (first.minute == second.minute){
        result = true;
      }else{
        result = false;
      }
    }
    return result;
  }

  bool timeLowerOrEqualThanX(TimeOfDay first, TimeOfDay second){
    bool result = false;
    if(first.hour < second.hour){
      result = true;
    }
    else if(first.hour == second.hour){
      if(first.minute < second.minute){
        result = true;
      }
      else if (first.minute == second.minute){
        result = true;
      }else{
        result = false;
      }
    }
    return result;
  }

  TimeOfDay maxProductTime(Pedido current){
    TimeOfDay result = TimeOfDay.now();
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
    result = generateHour(hours.toInt(), newTime.toInt(), result);
    return result;
  }

  TimeOfDay generateHour(int plusHours, int plusMinutes, TimeOfDay current){
    double currentHour = current.hour.toDouble();
    double currentMinutes = current.minute.toDouble();
    double newMinutes = currentMinutes + plusMinutes;
    double extraHours = 0;
    if(newMinutes > 60){
      extraHours = newMinutes/60;
      newMinutes = newMinutes-(extraHours.toInt()*60);
    }
    double newHours = currentHour + plusHours + extraHours;
    if(newHours > 24){
      double times = newHours/24;
      newHours = newHours-(times.toInt()*24);
    }
    return TimeOfDay(hour: newHours.toInt(), minute: newMinutes.toInt());
  }

  cancelOrderWarning(BuildContext context, Pedido current){
    Widget yesButton = TextButton(
      child: Text("Si"),
      onPressed: () { current.carrito.clear(); Navigator.of(context).pop(); Navigator.of(context).pop();},
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

  int changeQuantity(int value, String operationType, Producto selected, Tienda currentShop, int total, Pedido actual, BuildContext context){
    if(operationType == "Sum"){
      total+=value;
      int newQuantity = actual.carrito[currentShop]![selected]!+1;
      actual.carrito[currentShop]![selected] = newQuantity;
    }else if(operationType == "Substract"){
      total-=value;
      int newQuantity = actual.carrito[currentShop]![selected]!-1;
      actual.carrito[currentShop]![selected] = newQuantity;
    }else if(operationType == "Delete"){
      actual.carrito[currentShop]!.remove(selected);
      if(actual.carrito[currentShop]!.isEmpty){
        actual.carrito.remove(currentShop);
      }
      total-=value;
    }
    return total;
  }

}
