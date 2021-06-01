import 'dart:convert';
import 'package:Toppick_App/Products/Models/especialidad.dart';
import 'package:Toppick_App/Products/Models/producto.dart';
import 'package:Toppick_App/Shops/Models/tienda.dart';

import '../Models/pedido.dart';
import 'package:http/http.dart' as http;

class OrdersQueries {
  String domain = 'toppickapp.herokuapp.com';

  Future<List<Pedido>> getOrderHistory(String cookie) async {
    final response = await http.get(
      Uri.https(this.domain, '/pedidos/usuario'),
      headers: {"Accept": "application/json", "Cookie":cookie}
    );
    if (response.statusCode == 200) {
        return parseOrderHistory(response.body);
    } else { 
        throw Exception('Error');
    }
  }

  Future<List<Pedido>> getActiveOrders(String cookie) async {
    final response = await http.get(
      Uri.https(this.domain, '/pedidos/usuario'),
      headers: {"Accept": "application/json", "Cookie":cookie}
    );
    if (response.statusCode == 200) {
        return parseActiveOrders(response.body);
    } else { 
        throw Exception('Error');
    }
  }

  Future<bool> funcionDatos(Pedido pedido, dynamic prefs) async {
    bool result = false;
    bool error = false;
    String cookie = prefs.getString('cookie');
    int cantidadPedidos = prefs.getInt('pedidos actuales');
    var stringList = pedido.fechaCreacion.toIso8601String().split(new RegExp(r"[T\.]"));
    var formatedDateCreacion = "${stringList[0]} ${stringList[1]}";
    var stringList2 =  pedido.fechaReclamo.toIso8601String().split(new RegExp(r"[T\.]"));
    var formatedDateReclamo = "${stringList2[0]} ${stringList2[1]}";
    List<Map<String, dynamic>> peticiones = [];
    pedido.carrito.forEach((key, value) async {
        Map<String, dynamic> json = Map<String, dynamic>();
        json.addAll({"PuntoDeVenta_idPuntodeVenta": key!.id});
        json.addAll({"fechaCreacion": formatedDateCreacion});
        int costoTotal = 0;
        value.forEach((key, value) {
          costoTotal+=key.price*value;
        });
        json.addAll({"costoTotal": costoTotal});
        json.addAll({"fechaReclamo": formatedDateReclamo});
        json.addAll({"estadoPedido": pedido.estadoPedido});
        json.addAll({"razonRechazo": ""});
        List<Map<String,dynamic>> carrito = [];
        value.forEach((key, value) {
          Map<String, dynamic> current = Map<String, dynamic>();
          current.addAll({"Producto_idProducto":key.id});
          current.addAll({"CantidadProducto": value});
          current.addAll({"comentario":key.comments});
          if(key is Especialidad){
            List<Map<String,int>> acompanamientos = [];
            key.selecciones.forEach((key, value) {
              if(value){
                acompanamientos.add({"Acompañamiento_idAcompañamiento":key.id});
              }
            });
            current.addAll({"Acompañaminetos":acompanamientos});
          }
          carrito.add(current);
        });
        json.addAll({"carrito":carrito});
        peticiones.add(json);
    });

    for (var element in peticiones){
      if(!error){
        result =  await this.sendOrder(element,cookie);
        print("llego respuesta");
        if(result == false){
          error = true;
          print("ocurrió error");
        }else{
          cantidadPedidos+=1;
          print(cantidadPedidos);
          prefs.setInt('pedidos actuales', cantidadPedidos);
        }
      }
    }
    return result;
  }

  Future<bool> sendOrder(Map<String, dynamic> json, String cookie) async {
    var myBody = jsonEncode(json);
    print(myBody);
    final response = await http.post(
      Uri.https(this.domain, '/pedidos'),
      headers: {"Accept": "application/json", "Cookie":cookie, "content-type": "application/json"},
      body: myBody,
    );
    print(response.body);
    print(response.statusCode);
    if(response.statusCode == 200 ||response.statusCode == 201){
      return true;
    }else{
      return false;
    }
  }

  List<Pedido> parseActiveOrders(String responseBody){
    List<Pedido> result = [];
    int cont = 0;
    Pedido current = Pedido(0, DateTime.now(), 0, DateTime.now(), "estadoPedido");
    Tienda actual = Tienda(-1, "nombrePuntoDeVenta", "category", "description", "url", "status", "ubication",0);
    final first = json.decode(responseBody);
    final parsed = first['body'];
    int currentid = parsed[0]['idPedido'];
    for(var val in parsed){
      if(val['estadoPedido'] == "Solicitado" || val['estadoPedido'] == "Aceptado" || val['estadoPedido'] == "Listo"){
        if(currentid != val['idPedido']){
          result.add(current);
          currentid = val['idPedido'];
          current = Pedido.fromJsonList(val);
          actual = Tienda(-1, val['nombrePuntoDeVenta'], "category", "description", "url", "status", "ubication",0);
          for(var product in val['carrito']){
            Producto curr = Producto(-1, product['nombreProducto'], "description", 0, 0, 0, "ulrImage", "category", "type");
            int quantity = product['CantidadProducto'];
            if(current.storeIsInCurrentOrder(actual)){
              current.addProductToSelectedStore(actual, curr, quantity);
            }else{
              current.addStoreWithProducts(actual, curr, quantity);
            }
          }
          result.add(current);
          cont = 0;
          cont++;
        }else{
          if(cont==0){
            current = Pedido.fromJsonList(val);
            actual = Tienda(-1, val['nombrePuntoDeVenta'], "category", "description", "url", "status", "ubication",0);
          }
          for(var product in val['carrito']){
            Producto curr = Producto(-1, product['nombreProducto'], "description", 0, 0, 0, "ulrImage", "category", "type");
            int quantity = product['CantidadProducto'];
            if(current.storeIsInCurrentOrder(actual)){
              current.addProductToSelectedStore(actual, curr, quantity);
            }else{
              current.addStoreWithProducts(actual, curr, quantity);
            }
          }
          cont++;
          result.add(current);
        }
      }
    }
    return result;
  }

  List<Pedido> parseOrderHistory(String responseBody){
    List<Pedido> result = [];
    int cont = 0;
    Pedido current = Pedido(0, DateTime.now(), 0, DateTime.now(), "estadoPedido");
    Tienda actual = Tienda(-1, "nombrePuntoDeVenta", "category", "description", "url", "status", "ubication",0);
    final first = json.decode(responseBody);
    final parsed = first['body'];
    int currentid = parsed[0]['idPedido'];
    for(var val in parsed){
      if(val['estadoPedido'] == "Rechazado" || val['estadoPedido'] == "Terminado"){
        if(currentid != val['idPedido']){
          currentid = val['idPedido'];
          current = Pedido.fromJsonList(val);
          actual = Tienda(-1, val['nombrePuntoDeVenta'], "category", "description", "url", "status", "ubication",0);
          for(var product in val['carrito']){
            Producto curr = Producto(-1, product['nombreProducto'], "description", 0, 0, 0, "ulrImage", "category", "type");
            int quantity = product['CantidadProducto'];
            if(current.storeIsInCurrentOrder(actual)){
              current.addProductToSelectedStore(actual, curr, quantity);
            }else{
              current.addStoreWithProducts(actual, curr, quantity);
            }
          }
          result.add(current);
          cont = 0;
          cont++;
        }else{
          if(cont==0){
            current = Pedido.fromJsonList(val);
            actual = Tienda(-1, val['nombrePuntoDeVenta'], "category", "description", "url", "status", "ubication",0);
          }
          for(var product in val['carrito']){
            Producto curr = Producto(-1, product['nombreProducto'], "description", 0, 0, 0, "ulrImage", "category", "type");
            int quantity = product['CantidadProducto'];
            if(current.storeIsInCurrentOrder(actual)){
              current.addProductToSelectedStore(actual, curr, quantity);
            }else{
              current.addStoreWithProducts(actual, curr, quantity);
            }
          }
          result.add(current);
          cont++;
        }
      }
    }
    return result;
  }
}
