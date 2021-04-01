import 'package:Toppick_App/Shops/Models/horario.dart';
import 'package:flutter/material.dart';

import '../Models/tienda.dart';

class ShopQueries {
  List<Tienda> getAllAvailableShops() /*async*/ {
    List<Tienda> queryResult = [];
    /*
    final response =await http.get('https://');
    if (response.statusCode == 200) {
        //the call to the server was successful, 
        Iterable l = json.decode(response.body);
        List<Tienda> queryResult = List<Post>.from(l.map((model)=> Post.fromJson(model)));  
    
        throw Exception('Failed to load post');
        }
    */
    List<Horario> schedule = [
      Horario(TimeOfDay(hour: 6, minute: 0),TimeOfDay(hour: 21, minute: 0), ["Lunes", "Martes", "Miércoles", "Jueves", "Viernes"]),
      Horario(TimeOfDay(hour: 8, minute: 0),TimeOfDay(hour: 16, minute: 0), ["Sábado", "Domingo"]),
    ];
    List<Horario> schedule2 = [
      Horario(TimeOfDay(hour: 4, minute: 0),TimeOfDay(hour: 22, minute: 0), ["Lunes", "Martes", "Miércoles", "Jueves", "Viernes"]),
      Horario(TimeOfDay(hour: 8, minute: 0),TimeOfDay(hour: 16, minute: 0), ["Sábado", "Domingo"]),
    ];
    queryResult = [
      Tienda(
        1,
        "La Central",
        "Cafeterías",
        schedule,
        "En el restaurante La Central brindamos gran variedad de productos: desayunos, almuerzos, comidas rápidas, pizzas, opciones para llevar y un espacio cómodo, una experiencia única.",
        "assets/img/central.PNG",
        true,
        "https://www.google.com/maps/dir//la+central+javeriana/data=!4m6!4m5!1m1!4e2!1m2!1m1!1s0x8e3f9b5f5fdde08f:0x19a674df1df81bae?sa=X&ved=2ahUKEwiBnN-jyKnvAhVju1kKHewoCP4Q9RcwAHoECAQQAw",
      ),
      Tienda(
        2,
        "La Central",
        "Cafeterías",
        schedule2,
        "En el restaurante La Central brindamos gran variedad de productos: desayunos, almuerzos, comidas rápidas, pizzas, opciones para llevar y un espacio cómodo, una experiencia única.",
        "assets/img/central.PNG",
        true,
        "https://www.google.com/maps/dir//la+central+javeriana/data=!4m6!4m5!1m1!4e2!1m2!1m1!1s0x8e3f9b5f5fdde08f:0x19a674df1df81bae?sa=X&ved=2ahUKEwiBnN-jyKnvAhVju1kKHewoCP4Q9RcwAHoECAQQAw",
      ),
      Tienda(
        3,
        "La Central",
        "Cafeterías",
        schedule2,
        "En el restaurante La Central brindamos gran variedad de productos: desayunos, almuerzos, comidas rápidas, pizzas, opciones para llevar y un espacio cómodo, una experiencia única.",
        "assets/img/central.PNG",
        true,
        "https://www.google.com/maps/dir//la+central+javeriana/data=!4m6!4m5!1m1!4e2!1m2!1m1!1s0x8e3f9b5f5fdde08f:0x19a674df1df81bae?sa=X&ved=2ahUKEwiBnN-jyKnvAhVju1kKHewoCP4Q9RcwAHoECAQQAw",
      ),
      Tienda(
        4,
        "La Central",
        "Cafeterías",
        schedule2,
        "En el restaurante La Central brindamos gran variedad de productos: desayunos, almuerzos, comidas rápidas, pizzas, opciones para llevar y un espacio cómodo, una experiencia única.",
        "assets/img/central.PNG",
        true,
        "https://www.google.com/maps/dir//la+central+javeriana/data=!4m6!4m5!1m1!4e2!1m2!1m1!1s0x8e3f9b5f5fdde08f:0x19a674df1df81bae?sa=X&ved=2ahUKEwiBnN-jyKnvAhVju1kKHewoCP4Q9RcwAHoECAQQAw",
      ),
      Tienda(
        5,
        "La Central",
        "Cafeterías",
        schedule2,
        "En el restaurante La Central brindamos gran variedad de productos: desayunos, almuerzos, comidas rápidas, pizzas, opciones para llevar y un espacio cómodo, una experiencia única.",
        "assets/img/central.PNG",
        true,
        "https://www.google.com/maps/dir//la+central+javeriana/data=!4m6!4m5!1m1!4e2!1m2!1m1!1s0x8e3f9b5f5fdde08f:0x19a674df1df81bae?sa=X&ved=2ahUKEwiBnN-jyKnvAhVju1kKHewoCP4Q9RcwAHoECAQQAw",
      ),
      Tienda(
        6,
        "La Central",
        "Cafés y Kioskos",
        schedule2,
        "En el restaurante La Central brindamos gran variedad de productos: desayunos, almuerzos, comidas rápidas, pizzas, opciones para llevar y un espacio cómodo, una experiencia única.",
        "assets/img/central.PNG",
        true,
        "https://www.google.com/maps/dir//la+central+javeriana/data=!4m6!4m5!1m1!4e2!1m2!1m1!1s0x8e3f9b5f5fdde08f:0x19a674df1df81bae?sa=X&ved=2ahUKEwiBnN-jyKnvAhVju1kKHewoCP4Q9RcwAHoECAQQAw",
      ),
    ];

    return queryResult;
  }

  Tienda getShopById(int id) /*async*/ {
    Tienda queryResult;
    /*
    final response =await http.get('https://');
    if (response.statusCode == 200) {
        //the call to the server was successful, 
        Iterable l = json.decode(response.body);
        List<Tienda> queryResult = List<Post>.from(l.map((model)=> Post.fromJson(model))); 
    } else {
    
        throw Exception('Failed to load post');
        }
    */
    List<Horario> schedule = [
      Horario(TimeOfDay(hour: 6, minute: 0),TimeOfDay(hour: 21, minute: 0), ["Lunes", "Martes", "Miércoles", "Jueves", "Viernes"]),
      Horario(TimeOfDay(hour: 8, minute: 0),TimeOfDay(hour: 16, minute: 0), ["Sábado", "Domingo"]),
    ];
    queryResult = Tienda(
      1,
      "La Central",
      "Cafeterías",
      schedule,
      "En el restaurante La Central brindamos gran variedad de productos: desayunos, almuerzos, comidas rápidas, pizzas, opciones para llevar y un espacio cómodo, una experiencia única.",
      "assets/img/central.PNG",
      true,
      "https://www.google.com/maps/dir//la+central+javeriana/data=!4m6!4m5!1m1!4e2!1m2!1m1!1s0x8e3f9b5f5fdde08f:0x19a674df1df81bae?sa=X&ved=2ahUKEwiBnN-jyKnvAhVju1kKHewoCP4Q9RcwAHoECAQQAw",
    );
    return queryResult;
  }

  List<Tienda> getAvailableShopsByProduct(int productId) /*async*/ {
    List<Tienda> queryResult = [];
    /*
    final response =await http.get('https://');
    if (response.statusCode == 200) {
        //the call to the server was successful, 
        Iterable l = json.decode(response.body);
        List<Tienda> queryResult = List<Post>.from(l.map((model)=> Post.fromJson(model)));  
    } else {
    
        throw Exception('Failed to load post');
        }
    */
    List<Horario> schedule = [
      Horario(TimeOfDay(hour: 6, minute: 0),TimeOfDay(hour: 21, minute: 0), ["Lunes", "Martes", "Miércoles", "Jueves", "Viernes"]),
      Horario(TimeOfDay(hour: 8, minute: 0),TimeOfDay(hour: 16, minute: 0), ["Sábado", "Domingo"]),
    ];
    List<Horario> schedule2 = [
      Horario(TimeOfDay(hour: 4, minute: 0),TimeOfDay(hour: 22, minute: 0), ["Lunes", "Martes", "Miércoles", "Jueves", "Viernes"]),
      Horario(TimeOfDay(hour: 8, minute: 0),TimeOfDay(hour: 16, minute: 0), ["Sábado", "Domingo"]),
    ];
    queryResult = [
      Tienda(
        1,
        "La Central",
        "Cafeterías",
        schedule,
        "En el restaurante La Central brindamos gran variedad de productos: desayunos, almuerzos, comidas rápidas, pizzas, opciones para llevar y un espacio cómodo, una experiencia única.",
        "assets/img/central.PNG",
        true,
        "https://www.google.com/maps/dir//la+central+javeriana/data=!4m6!4m5!1m1!4e2!1m2!1m1!1s0x8e3f9b5f5fdde08f:0x19a674df1df81bae?sa=X&ved=2ahUKEwiBnN-jyKnvAhVju1kKHewoCP4Q9RcwAHoECAQQAw",
      ),
      Tienda(
        2,
        "La Central",
        "Cafeterías",
        schedule2,
        "En el restaurante La Central brindamos gran variedad de productos: desayunos, almuerzos, comidas rápidas, pizzas, opciones para llevar y un espacio cómodo, una experiencia única.",
        "assets/img/central.PNG",
        true,
        "https://www.google.com/maps/dir//la+central+javeriana/data=!4m6!4m5!1m1!4e2!1m2!1m1!1s0x8e3f9b5f5fdde08f:0x19a674df1df81bae?sa=X&ved=2ahUKEwiBnN-jyKnvAhVju1kKHewoCP4Q9RcwAHoECAQQAw",
      ),
      Tienda(
        3,
        "La Central",
        "Cafeterías",
        schedule2,
        "En el restaurante La Central brindamos gran variedad de productos: desayunos, almuerzos, comidas rápidas, pizzas, opciones para llevar y un espacio cómodo, una experiencia única.",
        "assets/img/central.PNG",
        true,
        "https://www.google.com/maps/dir//la+central+javeriana/data=!4m6!4m5!1m1!4e2!1m2!1m1!1s0x8e3f9b5f5fdde08f:0x19a674df1df81bae?sa=X&ved=2ahUKEwiBnN-jyKnvAhVju1kKHewoCP4Q9RcwAHoECAQQAw",
      ),
      Tienda(
        4,
        "La Central",
        "Cafeterías",
        schedule2,
        "En el restaurante La Central brindamos gran variedad de productos: desayunos, almuerzos, comidas rápidas, pizzas, opciones para llevar y un espacio cómodo, una experiencia única.",
        "assets/img/central.PNG",
        true,
        "https://www.google.com/maps/dir//la+central+javeriana/data=!4m6!4m5!1m1!4e2!1m2!1m1!1s0x8e3f9b5f5fdde08f:0x19a674df1df81bae?sa=X&ved=2ahUKEwiBnN-jyKnvAhVju1kKHewoCP4Q9RcwAHoECAQQAw",
      ),
      Tienda(
        5,
        "La Central",
        "Cafeterías",
        schedule2,
        "En el restaurante La Central brindamos gran variedad de productos: desayunos, almuerzos, comidas rápidas, pizzas, opciones para llevar y un espacio cómodo, una experiencia única.",
        "assets/img/central.PNG",
        true,
        "https://www.google.com/maps/dir//la+central+javeriana/data=!4m6!4m5!1m1!4e2!1m2!1m1!1s0x8e3f9b5f5fdde08f:0x19a674df1df81bae?sa=X&ved=2ahUKEwiBnN-jyKnvAhVju1kKHewoCP4Q9RcwAHoECAQQAw",
      ),
      Tienda(
        6,
        "La Central",
        "Cafés y Kioskos",
        schedule2,
        "En el restaurante La Central brindamos gran variedad de productos: desayunos, almuerzos, comidas rápidas, pizzas, opciones para llevar y un espacio cómodo, una experiencia única.",
        "assets/img/central.PNG",
        true,
        "https://www.google.com/maps/dir//la+central+javeriana/data=!4m6!4m5!1m1!4e2!1m2!1m1!1s0x8e3f9b5f5fdde08f:0x19a674df1df81bae?sa=X&ved=2ahUKEwiBnN-jyKnvAhVju1kKHewoCP4Q9RcwAHoECAQQAw",
      ),
    ];
    return queryResult;
  }
}
