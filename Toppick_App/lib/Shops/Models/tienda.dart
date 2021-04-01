import 'package:Toppick_App/Shops/Models/horario.dart';
import 'package:flutter/material.dart';

class Tienda {
  int id;
  String name;
  String category;
  List<Horario> schedule;
  String description;
  String url;
  bool status;
  String ubication;
  Tienda(this.id, this.name, this.category, this.schedule, this.description, this.url,
      this.status, this.ubication);
  @override
  // ignore: hash_and_equals
  bool operator ==(object){
    return (object is Tienda) && object.id == this.id;
  }

  String toStringSchedule(){
    String result = "";
    for(Horario current in this.schedule){
      result+=current.toString()+"\n";
    }
    return result;
  }

  TimeOfDay? getScheduleEndHour(String day){
    for(Horario current in this.schedule){
      if(current.dias.contains(day)){
        return current.horaCierre;
      }
    }
    return null;
  }

  TimeOfDay? getScheduleStartHour(String day){
    for(Horario current in this.schedule){
      if(current.dias.contains(day)){
        return current.horaApertura;
      }
    }
    return null;
  }
}
