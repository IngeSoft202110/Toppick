import '../Models/pedido.dart';

class OrdersQueries {
  List<Pedido> getFavoriteOrders() /*async*/
  {
    /*
    final response =await http.get('https://');
     if (response.statusCode == 200) {
        //the call to the server was successful, 
         Iterable l = json.decode(response.body);
         List<Pedido> queryResult = List<Post>.from(l.map((model)=> Post.fromJson(model))); 
    } else {
    
        throw Exception('Failed to load post');
        }
    */
    List<Pedido> queryResult = [];
    return queryResult;
  }

  List<Pedido> getOrderHistory() /*async*/ {
    /*
    final response =await http.get('https://');
     if (response.statusCode == 200) {
        //the call to the server was successful, 
         Iterable l = json.decode(response.body);
         List<Pedido> queryResult = List<Post>.from(l.map((model)=> Post.fromJson(model))); 
    } else {
    
        throw Exception('Failed to load post');
        }
    */
    List<Pedido> queryResult = [];
    return queryResult;
  }

  Pedido getOrderStatusResponse() /*async*/ {
    /*
    final response =await http.get('https://');
     if (response.statusCode == 200) {
        //the call to the server was successful, 
         Iterable l = json.decode(response.body);
         Pedido queryResult =Post.fromJson(model); 
    } else {
    
        throw Exception('Failed to load post');
        }
    */
    Pedido queryResult = Pedido(0, DateTime.now(), 0, 0, "En proceso");
    return queryResult;
  }

  /*Future<http.Response> */ bool postOrder(Pedido order) {
    /*
    return http.post(
    Uri.https('jsonplaceholder.typicode.com', 'Pedido'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      'title': title,
    }),
  );
    */
    return false;
  }
}
