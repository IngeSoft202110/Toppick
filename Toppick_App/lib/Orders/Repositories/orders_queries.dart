import 'dart:convert';

import 'package:Toppick_App/Products/Models/especialidad.dart';
import 'package:Toppick_App/Products/Models/producto.dart';
import 'package:Toppick_App/Shops/Models/tienda.dart';

import '../Models/pedido.dart';
import 'package:http/http.dart' as http;

class OrdersQueries {
  int port = 3000;
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

  Future<void> funcionDatos(Pedido pedido) async {
    var stringList = pedido.fechaCreacion.toIso8601String().split(new RegExp(r"[T\.]"));
    var formatedDate = "${stringList[0]} ${stringList[1]}";
    var stringList2 =  pedido.fechaReclamo.toIso8601String().split(new RegExp(r"[T\.]"));
    var formatedDate2 = "${stringList2[0]} ${stringList2[1]}";

    var orden = [];
    orden.add(pedido.idPedido);
    orden.add(formatedDate);
    orden.add(pedido.costoTotal);
    orden.add(formatedDate2);
    orden.add(pedido.estadoPedido);
    orden.add(pedido.razonRechazo);

    var car = [];
    var acompanamientos = [];

    void action(key, value) {
      value.forEach((k, v) {
        List<dynamic> aux = [];
        //id del producto
        aux.add(k.id);
        //id del pedido
        aux.add(0);
        //cantidad solicitada
        aux.add(v);
        //comentarios
        aux.add(k.comments);
        car.add(aux);
        if (k is Especialidad) {
          k.selecciones.forEach((kk, vv) {
            List<int> aux2 = [];
            if (vv) {
              aux2.add(k.id);
              aux2.add(kk.id);
              aux2.add(0);
              acompanamientos.add(aux2);
            }
          });
        }
      });
      print("Esto es una tienda diferente");
      var copy = [] ;
      copy.addAll(orden);
      copy.insert(1,key.id);//Este es el id de la tienda
      copy.insert(2,1);//ese 1 es el id del usuario
      sendOrder(copy,car,acompanamientos);
      car.clear();
      acompanamientos.clear();
    }
    pedido.carrito.forEach(action);
  }

  Future<void> sendOrder(var orden, var car, var acompanamientos)
  async {
    print(orden);
    final http.Response response = await http.post(Uri.http('10.0.2.2:$port','toppick/app/insert/order'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
    },
      body: jsonEncode({
        'orden': orden,
        'carrito': car,
        'acompanamientos': acompanamientos
      }),
    );
    if (response.statusCode == 200) {
        print("Pedido enviado");
    } else { 
        throw Exception('Error');
    }
  }
  List<Pedido> parseActiveOrders(String responseBody){
    List<Pedido> result = [];
    int cont = 0;
    Pedido current = Pedido(0, DateTime.now(), 0, DateTime.now(), "estadoPedido");
    Tienda actual = Tienda(-1, "nombrePuntoDeVenta", "category", "description", "url", "status", "ubication",0);
    final first = json.decode(responseBody);
    final parsed = first['body'].cast<Map<String, dynamic>>();
    print(parsed);
    int currentid = parsed[0]['idPedido'];
    for(var val in parsed){
      if(val['estadoPedido'] == "Solicitado" || val['estadoPedido'] == "Aceptado" || val['estadoPedido'] == "Listo"){
        if(currentid != val['idPedido']){
          result.add(current);
          currentid = val['idPedido'];
          current = Pedido.fromJsonList(val);
          actual = Tienda(-1, val['nombrePuntoDeVenta'], "category", "description", "url", "status", "ubication",0);
          Producto product = Producto(-1, val['nombreProducto'], "description", 0, 0, 0, "ulrImage", "category", "type");
          int quantity = val['cantidadProducto'];
          if(current.storeIsInCurrentOrder(actual)){
            current.addProductToSelectedStore(actual, product, quantity);
          }else{
            current.addStoreWithProducts(actual, product, quantity);
          }
          cont = 0;
          cont++;
        }else{
          if(cont==0){
            current = Pedido.fromJsonList(val);
            actual = Tienda(-1, val['nombrePuntoDeVenta'], "category", "description", "url", "status", "ubication",0);
          }
          Producto product = Producto(-1, val['nombreProducto'], "description", 0, 0, 0, "ulrImage", "category", "type");
          int quantity = val['cantidadProducto'];
          if(current.storeIsInCurrentOrder(actual)){
            current.addProductToSelectedStore(actual, product, quantity);
          }else{
            current.addStoreWithProducts(actual, product, quantity);
          }
          cont++;
        }
      }
    }
    result.add(current);
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
          result.add(current);
          currentid = val['idPedido'];
          current = Pedido.fromJsonList(val);
          actual = Tienda(-1, val['nombrePuntoDeVenta'], "category", "description", "url", "status", "ubication",0);
          Producto product = Producto(-1, val['nombreProducto'], "description", 0, 0, 0, "ulrImage", "category", "type");
          int quantity = val['cantidadProducto'];
          if(current.storeIsInCurrentOrder(actual)){
            current.addProductToSelectedStore(actual, product, quantity);
          }else{
            current.addStoreWithProducts(actual, product, quantity);
          }
          cont = 0;
          cont++;
        }else{
          if(cont==0){
            current = Pedido.fromJsonList(val);
            actual = Tienda(-1, val['nombrePuntoDeVenta'], "category", "description", "url", "status", "ubication",0);
          }
          Producto product = Producto(-1, val['nombreProducto'], "description", 0, 0, 0, "ulrImage", "category", "type");
          int quantity = val['cantidadProducto'];
          if(current.storeIsInCurrentOrder(actual)){
            current.addProductToSelectedStore(actual, product, quantity);
          }else{
            current.addStoreWithProducts(actual, product, quantity);
          }
          cont++;
        }
      }
    }
    return result;
  }
}
