import 'package:flutter/material.dart';

class Horario{
  TimeOfDay horaApertura;
  TimeOfDay horaCierre;
  List<String> dias;
  Horario(this.horaApertura, this.horaCierre, this.dias);

  String toString(){
    String value1 = horaApertura.hour<12 ? "AM":"PM";
    String value2 = horaCierre.hour<12 ? "AM":"PM";
    String hour_1, hour_2 = "";
    String minute_1 = horaApertura.minute<10 ? "0"+horaApertura.minute.toString() : horaApertura.minute.toString();
    String minute_2 = horaCierre.minute<10 ? "0"+horaCierre.minute.toString() : horaCierre.minute.toString();
    if(horaApertura.hour<10){ 
      hour_1="0"+horaApertura.hour.toString();
    }else{
      if(horaApertura.hour > 12){
        hour_1=(horaApertura.hour-12).toString();
      }else{
        hour_1 = horaApertura.hour.toString();
      }
    }
    if(horaCierre.hour<10){ 
      hour_2="0"+horaCierre.hour.toString();
    }else{
      if(horaCierre.hour > 12){
        hour_2=(horaCierre.hour-12).toString();
      }else{
        hour_2 = horaCierre.hour.toString();
      } 
    }
    return dias.first.substring(0,2)+"-"+dias.last.substring(0,2)+": "+hour_1+":"+minute_1+" "+value1
      +" a "+hour_2+":"+minute_2+" "+value2;
  }
}