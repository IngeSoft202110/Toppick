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
        "Cafeterías",
        "L-V: 6:00 A.M - 9:00 P.M \n S: 8:00 am a 4:00pm",
        "En el restaurante La Central brindamos gran variedad de productos: desayunos, almuerzos, comidas rápidas, pizzas, opciones para llevar y un espacio cómodo, una experiencia única.",
        "assets/img/central.PNG",
        true,
        "https://www.google.com/maps/dir//la+central+javeriana/data=!4m6!4m5!1m1!4e2!1m2!1m1!1s0x8e3f9b5f5fdde08f:0x19a674df1df81bae?sa=X&ved=2ahUKEwiBnN-jyKnvAhVju1kKHewoCP4Q9RcwAHoECAQQAw",
      ),
      Tienda(
        2,
        "La Central",
        "Cafeterías",
        "L-V: 6:00 A.M - 9:00 P.M \n S: 8:00 am a 4:00pm",
        "En el restaurante La Central brindamos gran variedad de productos: desayunos, almuerzos, comidas rápidas, pizzas, opciones para llevar y un espacio cómodo, una experiencia única.",
        "assets/img/central.PNG",
        true,
        "https://www.google.com/maps/dir//la+central+javeriana/data=!4m6!4m5!1m1!4e2!1m2!1m1!1s0x8e3f9b5f5fdde08f:0x19a674df1df81bae?sa=X&ved=2ahUKEwiBnN-jyKnvAhVju1kKHewoCP4Q9RcwAHoECAQQAw",
      ),
      Tienda(
        3,
        "La Central",
        "Cafeterías",
        "L-V: 6:00 A.M - 9:00 P.M \n S: 8:00 am a 4:00pm",
        "En el restaurante La Central brindamos gran variedad de productos: desayunos, almuerzos, comidas rápidas, pizzas, opciones para llevar y un espacio cómodo, una experiencia única.",
        "assets/img/central.PNG",
        true,
        "https://www.google.com/maps/dir//la+central+javeriana/data=!4m6!4m5!1m1!4e2!1m2!1m1!1s0x8e3f9b5f5fdde08f:0x19a674df1df81bae?sa=X&ved=2ahUKEwiBnN-jyKnvAhVju1kKHewoCP4Q9RcwAHoECAQQAw",
      ),
      Tienda(
        4,
        "La Central",
        "Cafeterías",
        "L-V: 6:00 A.M - 9:00 P.M \n S: 8:00 am a 4:00pm",
        "En el restaurante La Central brindamos gran variedad de productos: desayunos, almuerzos, comidas rápidas, pizzas, opciones para llevar y un espacio cómodo, una experiencia única.",
        "assets/img/central.PNG",
        true,
        "https://www.google.com/maps/dir//la+central+javeriana/data=!4m6!4m5!1m1!4e2!1m2!1m1!1s0x8e3f9b5f5fdde08f:0x19a674df1df81bae?sa=X&ved=2ahUKEwiBnN-jyKnvAhVju1kKHewoCP4Q9RcwAHoECAQQAw",
      ),
      Tienda(
        5,
        "La Central",
        "Cafeterías",
        "L-V: 6:00 A.M - 9:00 P.M \n S: 8:00 am a 4:00pm",
        "En el restaurante La Central brindamos gran variedad de productos: desayunos, almuerzos, comidas rápidas, pizzas, opciones para llevar y un espacio cómodo, una experiencia única.",
        "assets/img/central.PNG",
        true,
        "https://www.google.com/maps/dir//la+central+javeriana/data=!4m6!4m5!1m1!4e2!1m2!1m1!1s0x8e3f9b5f5fdde08f:0x19a674df1df81bae?sa=X&ved=2ahUKEwiBnN-jyKnvAhVju1kKHewoCP4Q9RcwAHoECAQQAw",
      ),
      Tienda(
        6,
        "La Central",
        "Cafés y Kioskos",
        "L-V: 6:00 A.M - 9:00 P.M \n S: 8:00 am a 4:00pm",
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
    queryResult = Tienda(
      1,
      "La Central",
      "Cafeterías",
      "L-V: 6:00 A.M - 9:00 P.M \n S: 8:00 am a 4:00pm",
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
    queryResult = [
      Tienda(
        1,
        "La Central",
        "Cafeterías",
        "L-V: 6:00 A.M - 9:00 P.M \n S: 8:00 am a 4:00pm",
        "En el restaurante La Central brindamos gran variedad de productos: desayunos, almuerzos, comidas rápidas, pizzas, opciones para llevar y un espacio cómodo, una experiencia única.",
        "assets/img/central.PNG",
        true,
        "https://www.google.com/maps/dir//la+central+javeriana/data=!4m6!4m5!1m1!4e2!1m2!1m1!1s0x8e3f9b5f5fdde08f:0x19a674df1df81bae?sa=X&ved=2ahUKEwiBnN-jyKnvAhVju1kKHewoCP4Q9RcwAHoECAQQAw",
      ),
      Tienda(
        2,
        "La Central",
        "Cafeterías",
        "L-V: 6:00 A.M - 9:00 P.M \n S: 8:00 am a 4:00pm",
        "En el restaurante La Central brindamos gran variedad de productos: desayunos, almuerzos, comidas rápidas, pizzas, opciones para llevar y un espacio cómodo, una experiencia única.",
        "assets/img/central.PNG",
        true,
        "https://www.google.com/maps/dir//la+central+javeriana/data=!4m6!4m5!1m1!4e2!1m2!1m1!1s0x8e3f9b5f5fdde08f:0x19a674df1df81bae?sa=X&ved=2ahUKEwiBnN-jyKnvAhVju1kKHewoCP4Q9RcwAHoECAQQAw",
      ),
      Tienda(
        3,
        "La Central",
        "Cafeterías",
        "L-V: 6:00 A.M - 9:00 P.M \n S: 8:00 am a 4:00pm",
        "En el restaurante La Central brindamos gran variedad de productos: desayunos, almuerzos, comidas rápidas, pizzas, opciones para llevar y un espacio cómodo, una experiencia única.",
        "assets/img/central.PNG",
        true,
        "https://www.google.com/maps/dir//la+central+javeriana/data=!4m6!4m5!1m1!4e2!1m2!1m1!1s0x8e3f9b5f5fdde08f:0x19a674df1df81bae?sa=X&ved=2ahUKEwiBnN-jyKnvAhVju1kKHewoCP4Q9RcwAHoECAQQAw",
      ),
      Tienda(
        4,
        "La Central",
        "Cafeterías",
        "L-V: 6:00 A.M - 9:00 P.M \n S: 8:00 am a 4:00pm",
        "En el restaurante La Central brindamos gran variedad de productos: desayunos, almuerzos, comidas rápidas, pizzas, opciones para llevar y un espacio cómodo, una experiencia única.",
        "assets/img/central.PNG",
        true,
        "https://www.google.com/maps/dir//la+central+javeriana/data=!4m6!4m5!1m1!4e2!1m2!1m1!1s0x8e3f9b5f5fdde08f:0x19a674df1df81bae?sa=X&ved=2ahUKEwiBnN-jyKnvAhVju1kKHewoCP4Q9RcwAHoECAQQAw",
      ),
      Tienda(
        5,
        "La Central",
        "Cafeterías",
        "L-V: 6:00 A.M - 9:00 P.M \n S: 8:00 am a 4:00pm",
        "En el restaurante La Central brindamos gran variedad de productos: desayunos, almuerzos, comidas rápidas, pizzas, opciones para llevar y un espacio cómodo, una experiencia única.",
        "assets/img/central.PNG",
        true,
        "https://www.google.com/maps/dir//la+central+javeriana/data=!4m6!4m5!1m1!4e2!1m2!1m1!1s0x8e3f9b5f5fdde08f:0x19a674df1df81bae?sa=X&ved=2ahUKEwiBnN-jyKnvAhVju1kKHewoCP4Q9RcwAHoECAQQAw",
      ),
      Tienda(
        6,
        "La Central",
        "Cafés y Kioskos",
        "L-V: 6:00 A.M - 9:00 P.M \n S: 8:00 am a 4:00pm",
        "En el restaurante La Central brindamos gran variedad de productos: desayunos, almuerzos, comidas rápidas, pizzas, opciones para llevar y un espacio cómodo, una experiencia única.",
        "assets/img/central.PNG",
        true,
        "https://www.google.com/maps/dir//la+central+javeriana/data=!4m6!4m5!1m1!4e2!1m2!1m1!1s0x8e3f9b5f5fdde08f:0x19a674df1df81bae?sa=X&ved=2ahUKEwiBnN-jyKnvAhVju1kKHewoCP4Q9RcwAHoECAQQAw",
      ),
    ];
    return queryResult;
  }
}
