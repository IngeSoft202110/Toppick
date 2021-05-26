import 'package:Toppick_App/Shops/Models/horario.dart';
import 'package:flutter/material.dart';

class Tienda {
  int id;
  String name;
  String category;
  List<Horario> schedule = [];
  String description;
  String url;
  String status;
  String ubication;
  Tienda(this.id, this.name, this.category, this.description, this.url,
      this.status, this.ubication);
  @override
  bool operator ==(object){
    return (object is Tienda) && object.id == this.id;
  }
  @override
  int get hashCode => this.id;

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

  factory Tienda.fromJson(Map<String, dynamic> json){
    return Tienda(
      json['idPuntodeVenta'],
      json['nombrePuntoDeVenta'],
      json['tipoPuntoVenta'],
      json['descripcion'],
      'assets/img/central.PNG',
      json['Estado'],
      json['urlUbicacion']
    );
  }

}
