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
    queryResult = [
      Tienda(
        1,
        "La Central",
        "Cafeterias",
        "L-V: 6:00 A.M - 9:00 P.M \n S: 8:00 am a 4:00pm",
        "En el restaurante La Central brindamos gran variedad de productos: desayunos, almuerzos, comidas rapidas, pizzas, opciones para llevar y un espacio comodo, una experiencia unica ",
        "assets/img/central.PNG",
        true,
        "https://www.google.com/maps/dir//la+central+javeriana/data=!4m6!4m5!1m1!4e2!1m2!1m1!1s0x8e3f9b5f5fdde08f:0x19a674df1df81bae?sa=X&ved=2ahUKEwiBnN-jyKnvAhVju1kKHewoCP4Q9RcwAHoECAQQAw",
      ),
      Tienda(
        2,
        "La Central",
        "Cafeterias",
        "L-V: 6:00 A.M - 9:00 P.M \n S: 8:00 am a 4:00pm",
        "En el restaurante La Central brindamos gran variedad de productos: desayunos, almuerzos, comidas rapidas, pizzas, opciones para llevar y un espacio comodo, una experiencia unica ",
        "assets/img/central.PNG",
        true,
        "https://www.google.com/maps/dir//la+central+javeriana/data=!4m6!4m5!1m1!4e2!1m2!1m1!1s0x8e3f9b5f5fdde08f:0x19a674df1df81bae?sa=X&ved=2ahUKEwiBnN-jyKnvAhVju1kKHewoCP4Q9RcwAHoECAQQAw",
      ),
      Tienda(
        3,
        "La Central",
        "Cafeterias",
        "L-V: 6:00 A.M - 9:00 P.M \n S: 8:00 am a 4:00pm",
        "En el restaurante La Central brindamos gran variedad de productos: desayunos, almuerzos, comidas rapidas, pizzas, opciones para llevar y un espacio comodo, una experiencia unica ",
        "assets/img/central.PNG",
        true,
        "https://www.google.com/maps/dir//la+central+javeriana/data=!4m6!4m5!1m1!4e2!1m2!1m1!1s0x8e3f9b5f5fdde08f:0x19a674df1df81bae?sa=X&ved=2ahUKEwiBnN-jyKnvAhVju1kKHewoCP4Q9RcwAHoECAQQAw",
      ),
      Tienda(
        4,
        "La Central",
        "Cafeterias",
        "L-V: 6:00 A.M - 9:00 P.M \n S: 8:00 am a 4:00pm",
        "En el restaurante La Central brindamos gran variedad de productos: desayunos, almuerzos, comidas rapidas, pizzas, opciones para llevar y un espacio comodo, una experiencia unica ",
        "assets/img/central.PNG",
        true,
        "https://www.google.com/maps/dir//la+central+javeriana/data=!4m6!4m5!1m1!4e2!1m2!1m1!1s0x8e3f9b5f5fdde08f:0x19a674df1df81bae?sa=X&ved=2ahUKEwiBnN-jyKnvAhVju1kKHewoCP4Q9RcwAHoECAQQAw",
      ),
      Tienda(
        5,
        "La Central",
        "Cafeterias",
        "L-V: 6:00 A.M - 9:00 P.M \n S: 8:00 am a 4:00pm",
        "En el restaurante La Central brindamos gran variedad de productos: desayunos, almuerzos, comidas rapidas, pizzas, opciones para llevar y un espacio comodo, una experiencia unica ",
        "assets/img/central.PNG",
        true,
        "https://www.google.com/maps/dir//la+central+javeriana/data=!4m6!4m5!1m1!4e2!1m2!1m1!1s0x8e3f9b5f5fdde08f:0x19a674df1df81bae?sa=X&ved=2ahUKEwiBnN-jyKnvAhVju1kKHewoCP4Q9RcwAHoECAQQAw",
      ),
      Tienda(
        6,
        "La Central",
        "Cafes y Kioskos",
        "L-V: 6:00 A.M - 9:00 P.M \n S: 8:00 am a 4:00pm",
        "En el restaurante La Central brindamos gran variedad de productos: desayunos, almuerzos, comidas rapidas, pizzas, opciones para llevar y un espacio comodo, una experiencia unica ",
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
    queryResult = Tienda(
      1,
      "La Central",
      "Cafeterias",
      "L-V: 6:00 A.M - 9:00 P.M \n S: 8:00 am a 4:00pm",
      "En el restaurante La Central brindamos gran variedad de productos: desayunos, almuerzos, comidas rapidas, pizzas, opciones para llevar y un espacio comodo, una experiencia unica ",
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
    queryResult = [
      Tienda(
        1,
        "La Central",
        "Cafeterias",
        "L-V: 6:00 A.M - 9:00 P.M \n S: 8:00 am a 4:00pm",
        "En el restaurante La Central brindamos gran variedad de productos: desayunos, almuerzos, comidas rapidas, pizzas, opciones para llevar y un espacio comodo, una experiencia unica ",
        "assets/img/central.PNG",
        true,
        "https://www.google.com/maps/dir//la+central+javeriana/data=!4m6!4m5!1m1!4e2!1m2!1m1!1s0x8e3f9b5f5fdde08f:0x19a674df1df81bae?sa=X&ved=2ahUKEwiBnN-jyKnvAhVju1kKHewoCP4Q9RcwAHoECAQQAw",
      ),
      Tienda(
        2,
        "La Central",
        "Cafeterias",
        "L-V: 6:00 A.M - 9:00 P.M \n S: 8:00 am a 4:00pm",
        "En el restaurante La Central brindamos gran variedad de productos: desayunos, almuerzos, comidas rapidas, pizzas, opciones para llevar y un espacio comodo, una experiencia unica ",
        "assets/img/central.PNG",
        true,
        "https://www.google.com/maps/dir//la+central+javeriana/data=!4m6!4m5!1m1!4e2!1m2!1m1!1s0x8e3f9b5f5fdde08f:0x19a674df1df81bae?sa=X&ved=2ahUKEwiBnN-jyKnvAhVju1kKHewoCP4Q9RcwAHoECAQQAw",
      ),
      Tienda(
        3,
        "La Central",
        "Cafeterias",
        "L-V: 6:00 A.M - 9:00 P.M \n S: 8:00 am a 4:00pm",
        "En el restaurante La Central brindamos gran variedad de productos: desayunos, almuerzos, comidas rapidas, pizzas, opciones para llevar y un espacio comodo, una experiencia unica ",
        "assets/img/central.PNG",
        true,
        "https://www.google.com/maps/dir//la+central+javeriana/data=!4m6!4m5!1m1!4e2!1m2!1m1!1s0x8e3f9b5f5fdde08f:0x19a674df1df81bae?sa=X&ved=2ahUKEwiBnN-jyKnvAhVju1kKHewoCP4Q9RcwAHoECAQQAw",
      ),
      Tienda(
        4,
        "La Central",
        "Cafeterias",
        "L-V: 6:00 A.M - 9:00 P.M \n S: 8:00 am a 4:00pm",
        "En el restaurante La Central brindamos gran variedad de productos: desayunos, almuerzos, comidas rapidas, pizzas, opciones para llevar y un espacio comodo, una experiencia unica ",
        "assets/img/central.PNG",
        true,
        "https://www.google.com/maps/dir//la+central+javeriana/data=!4m6!4m5!1m1!4e2!1m2!1m1!1s0x8e3f9b5f5fdde08f:0x19a674df1df81bae?sa=X&ved=2ahUKEwiBnN-jyKnvAhVju1kKHewoCP4Q9RcwAHoECAQQAw",
      ),
      Tienda(
        5,
        "La Central",
        "Cafeterias",
        "L-V: 6:00 A.M - 9:00 P.M \n S: 8:00 am a 4:00pm",
        "En el restaurante La Central brindamos gran variedad de productos: desayunos, almuerzos, comidas rapidas, pizzas, opciones para llevar y un espacio comodo, una experiencia unica ",
        "assets/img/central.PNG",
        true,
        "https://www.google.com/maps/dir//la+central+javeriana/data=!4m6!4m5!1m1!4e2!1m2!1m1!1s0x8e3f9b5f5fdde08f:0x19a674df1df81bae?sa=X&ved=2ahUKEwiBnN-jyKnvAhVju1kKHewoCP4Q9RcwAHoECAQQAw",
      ),
      Tienda(
        6,
        "La Central",
        "Cafes y Kioskos",
        "L-V: 6:00 A.M - 9:00 P.M \n S: 8:00 am a 4:00pm",
        "En el restaurante La Central brindamos gran variedad de productos: desayunos, almuerzos, comidas rapidas, pizzas, opciones para llevar y un espacio comodo, una experiencia unica ",
        "assets/img/central.PNG",
        true,
        "https://www.google.com/maps/dir//la+central+javeriana/data=!4m6!4m5!1m1!4e2!1m2!1m1!1s0x8e3f9b5f5fdde08f:0x19a674df1df81bae?sa=X&ved=2ahUKEwiBnN-jyKnvAhVju1kKHewoCP4Q9RcwAHoECAQQAw",
      ),
    ];
    return queryResult;
  }
}
