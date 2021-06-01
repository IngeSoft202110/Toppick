import 'package:Toppick_App/GeneralUserInterfaces/generic_button.dart';
import 'package:Toppick_App/GeneralUserInterfaces/gradiant.dart';
import 'package:Toppick_App/Orders/Bloc/order_controller.dart';
import 'package:Toppick_App/Orders/Models/pedido.dart';
import 'package:Toppick_App/Orders/UserInterfaces/add_subtract_total.dart';
import 'package:Toppick_App/Orders/UserInterfaces/payment_card.dart';
import 'package:Toppick_App/Orders/UserInterfaces/payment_selection.dart';
import 'package:Toppick_App/Products/Models/producto.dart';
import 'package:Toppick_App/Shops/Models/tienda.dart';
import 'package:Toppick_App/Users/Bloc/user_controller.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';


// ignore: must_be_immutable
class OrderCard extends StatefulWidget {
  OrderCard(this.actual, this.hKey, this.prefs, this.methods);
  final Pedido actual;
  final hKey;
  final prefs;
  List<dynamic> methods;

  int calculateTotal(){
    int total = 0;
    this.actual.carrito.forEach((key, value) {
      value.forEach((key, value) {
        total+=key.price*value;
      });
    });
    return total;
  }
  @override
  _OrderCardState createState() => _OrderCardState(this.actual,calculateTotal(), this.hKey);
}



class _OrderCardState extends State<OrderCard> {
  _OrderCardState(this.actual, this.total, this.hKey);
  final Pedido actual;
  int total;
  dynamic selected;
  OrderController controller = OrderController();
  UserController uContreoller = UserController();
  DateTime? minTime;
  TimeOfDay? _actualTime = TimeOfDay.now();
  DateTime? max2Hours;
  TimeOfDay? pickedTime;
  DateTime? maxShopTime;
  DateTime? minShopTime;
  DateTime? finalDateSend;
  final hKey;

  Future<Null> selectTime(BuildContext context) async{
    pickedTime = await showTimePicker(
      context: context, 
      initialTime: _actualTime!
    );
    if(pickedTime != null){
      DateTime current = DateTime.now();
      DateTime picked = DateTime.now();
      if(_actualTime!.hour > 12 && pickedTime!.hour < 12){
        picked = DateTime(current.year, current.month, current.day+1, pickedTime!.hour, pickedTime!.minute);
        maxShopTime!.add(Duration(days: 1));
        minShopTime!.add(Duration(days: 1));
        print("aaaa");
      }else{
        picked = DateTime(current.year, current.month, current.day, pickedTime!.hour, pickedTime!.minute);
      }
      DateTime actual = DateTime(current.year, current.month, current.day, _actualTime!.hour, _actualTime!.minute);
      bool exp1 = this.controller.isBeforeThan(picked, actual); //Si se selecciona una hora antes a la actual
      bool exp2 = this.controller.isOutOfRange(picked, maxShopTime!, minShopTime!); //Si está por fuera del rango de horario del punto de venta
      bool exp3 = this.controller.isAfterThan(picked, max2Hours!); //Si se selecciona una hora más allá de las 2 horas y media dadas
      bool exp4 = this.controller.isBeforeThan(picked, minTime!); //Si se selecciona una hora antes del tiempo minímo calculado
      if(exp1 || exp2 || exp3 || exp4){
        String text = "";
        if(exp1)
          text="Seleccionó una hora previa a la hora actual, por favor seleccione otra hora.";
        if(exp2)
          text="Seleccionó una hora fuera del rango de los puntos de venta a donde quiere enviar su pedido.";
        if(exp3)
          text="Seleccionó una hora más allá de las 2 horas y media posibles para realizar el pedido.";
        if(exp4)
          text="Seleccionó una hora previa al tiempo necesario para la preparación de los productos de su pedido.";
        this.controller.showPayHourWarning(context, text);
        pickedTime = null;
      }
      maxShopTime!.subtract(Duration(days: 1));
      minShopTime!.subtract(Duration(days: 1));
    }
  }

  void refresh(int value, String operationType, Producto selected, Tienda currentShop){
    setState(() {
      total = this.controller.changeQuantity(value, operationType, selected, currentShop, this.total, this.actual, context, this.hKey);
      if(total==0){
        this.controller.showEmptyOrder(context);
      }
    });
  }
  void updateMethod(dynamic selected) {
    this.selected = selected;
    print(this.selected.runtimeType);
  }

  List<Widget> fill(var transitionToPay){
    var cancelTransition = () => this.controller.cancelOrderWarning(context, actual, this.hKey);
    var formatter = NumberFormat('#,###,000');
    Widget showMethods = widget.methods.isNotEmpty ? RadioButtonPaymentList(widget.methods, updateMethod) :
      Center(
        child:Container(
          padding: const EdgeInsets.all(10.0),
          child: Text("No tienes métodos de pago registrados, por favor ve a tu perfil para registrar al menos un método.")
        )
      );
    List<Widget> result = [];
    result.add(
      Center(
        child: Padding(
          padding: const EdgeInsets.only(top: 10.0),
          child: Text("Pedido", style: TextStyle(color: Color(0xFFD76060), fontSize: 35, fontWeight: FontWeight.bold),),
        ),
      )
    );
    this.actual.carrito.forEach((key, value) {result.add(ShopxProductContent(key!, value, refresh));});
    result.add(
      Padding(
        padding: const EdgeInsets.only(left: 10.0, top: 30.0),
        child: Text("¿A qué hora pasas?", style: TextStyle(color: Color(0xFFD76060), fontSize: 25, fontWeight: FontWeight.bold)),
      )
    );
    result.add(
      Center(
        child: ElevatedButton(
          onPressed: () =>selectTime(context),
          child: Text("Selecciona una hora para recoger")
        )
      )
    );
    result.add(
      Padding(
        padding: const EdgeInsets.only(left: 10.0, right: 10.0, bottom: 15.0),
        child: Text("*El tiempo mínimo para pasar es el del producto que más se tarde en cocinar y el máximo es de dos horas y 30 min*", style: TextStyle(color: Color(0xFFB7B7B7), fontSize: 15)),
      )
    );
    result.add(
      Padding(
        padding: const EdgeInsets.only(left: 10.0,),
        child: Text("Métodos de pago", style: TextStyle(color: Color(0xFFD76060), fontSize: 30, fontWeight: FontWeight.bold),),
      ),
    );
    result.add(showMethods);
    bool exp11 = this.controller.isOutOfRange(this.minTime!, maxShopTime!, minShopTime!); //Si está por fuera del rango de horario del punto de venta
    bool exp22 = this.controller.isAfterThan(this.minTime!, max2Hours!); //Si se selecciona una hora más allá de las 2 horas y media dadas
    String text = "";
    if(exp11)
      text="La hora calculada está fuera del rango de horarios de los puntos de venta a donde quiere enviar su pedido.";
    if(exp22)
      text="La hora calculada supera las 2 horas y media posibles para realizar el pedido.";
    result.add(Center(child: GenericButton("Total: \$${formatter.format(this.total)}", Color(0xFFBB4900), 274, 45, 15.0, 0, 0, 0, 22, 0, () => {})));
    result.add(Center(child: GenericButton("Realizar Pedido", Color(0xFF0CC665), 274, 45, 15.0, 0, 0, 0, 22, 30, () => {
      if(selected==null){
        this.controller.showPayMethodWarning(context)
      }else{
          if(this.pickedTime != null){
            transitionToPay()
          }else{
            if(exp11 || exp22){
              this.controller.showMinTimeWarning(context, text)
            }else{
              transitionToPay()
            }
          }
        }
    })));
    result.add(Center(child: GenericButton("Cancelar Pedido", Color(0xFFFB2900), 274, 45, 15.0, 0, 0, 0, 22, 30, cancelTransition)));
    result.add(SizedBox(height: 30,));
    return result;
  }

  @override
  Widget build(BuildContext context) {
    Widget construct(BuildContext context){
      DateTime current = DateTime.now();
      if(this.pickedTime != null){
        this.finalDateSend = DateTime(current.year, current.month, current.day, this.pickedTime!.hour, this.pickedTime!.minute);
      }
      else{
        this.finalDateSend = DateTime(current.year, current.month, current.day, this.minTime!.hour, this.minTime!.minute);
      }
      if(this.selected.runtimeType.toString()=="DaviPlata"){
        return PaymentCard("assets/img/daviplata.png", total, selected, this.actual, this.finalDateSend!, widget.prefs);
      }
      else if(this.selected.runtimeType.toString()=="Nequi"){
        return PaymentCard("assets/img/nequi.jpg", total, selected, this.actual, this.finalDateSend!, widget.prefs);
      }
      else if(this.selected.runtimeType.toString()=="PSE"){
        return PaymentCard("assets/img/pse.jpg", total, selected, this.actual, this.finalDateSend!, widget.prefs);
      }  
      return OrderCard(this.actual, this.hKey, widget.prefs, widget.methods);
    }
    var payTransition = () => Navigator.push(context, MaterialPageRoute(builder: construct));
    this.maxShopTime = this.controller.getMaxShopsHour(this.actual, DateTime.now().weekday);
    print("Max shop time ${this.maxShopTime}");
    this.minShopTime = this.controller.getMinShopsHour(this.actual, DateTime.now().weekday);
    print("Min shop time ${this.minShopTime}");
    this.max2Hours = this.controller.generateHour(2, 30);
    print("Max 2 hours ${this.max2Hours}");
    this.minTime = this.controller.maxProductTime(this.actual);
    print("Max minTime ${this.minTime}");
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Gradiant(),
          Container(
            margin: EdgeInsets.only(top: 5.0),
            height: MediaQuery.of(context).size.height,
            width: double.infinity,
            child: ListView(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(bottom: 15.0),
                  child: Container(
                    height: 150,
                    child: Image.asset("assets/img/logo.png")
                  ),
                ),
                Container(
                  decoration: BoxDecoration(borderRadius: BorderRadius.only(topLeft: Radius.circular(40), topRight: Radius.circular(40)), color: Color(0xFFFFFEEE),),
                  child: Column(
                    key: Key(this.actual.carrito.length.toString()),
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: fill(payTransition),
                  )
                ),
              ],
            ),
          )
        ],
      )
    );
  }
}

Widget element(Producto current, Tienda shop, int currentQuantity, Function(int value, String operationType, Producto selected, Tienda currentShop) toCallChanges){
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: <Widget>[
      Flexible(
        child: Container(
          padding: new EdgeInsets.only(right: 13.0, left: 10.0),
          child: Text("${current.name}", style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 25,
                  color: Color(0xFFB7B7B7)), overflow: TextOverflow.ellipsis,),
        ),
      ),
      AddSubstract(current, shop, currentQuantity, toCallChanges),
    ],
  );
}

class ShopxProductContent extends StatelessWidget{
  ShopxProductContent(this.shop, this.products, this.notifyParent);
  final Tienda shop;
  final Map<Producto, int> products;
  final Function(int value,  String operationType, Producto selected, Tienda currentShop) notifyParent;

  List<Widget> fill(){
    List<Widget> result = [];
    result.add(
      Padding(
        padding: const EdgeInsets.only(left: 10.0, right: 10, bottom: 10.0),
        child: Text("${this.shop.name}", style: TextStyle(color: Color(0xFFD76060), fontSize: 25, fontWeight: FontWeight.bold),),
      )
    );
    this.products.forEach((key, value) {
      result.add(element(key, shop, value, notifyParent));
    });
    return result;
  }
  @override
  Widget build(BuildContext context) {
    return Column(
      children:fill(),
      crossAxisAlignment: CrossAxisAlignment.start,
    );
  }
}