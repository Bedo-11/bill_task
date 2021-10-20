import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'cart.dart';
import 'package:http/http.dart' as http;

class OrderItem {
  final String id;
  final double amount;
  final List<CartItem> products;
  final DateTime dateTime;

  OrderItem({
    this.id,
    this.amount,
    this.products,
    this.dateTime,
  });

  factory OrderItem.fromJson(Map<String, dynamic> json) => OrderItem(
        id: json["id"],
        amount: json["amount"],
        products: List<CartItem>.from(
            json["orderitems"].map((x) => CartItem.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "amount": amount,
      };
}

class Orders with ChangeNotifier {
  List<OrderItem> _orders = [];
  List<OrderItem> get orders {
    return [..._orders];
  }

  Future<void> getOrders() async {
    final url = Uri.parse(
        'https://athmany-api-default-rtdb.firebaseio.com/orders.json');
    final response = await http.get(url);
    final List<OrderItem> loadedOrders = [];
    final extractedData = json.decode(response.body) as Map<String, dynamic>;
    if (extractedData == null) {
      return;
    }
    extractedData.forEach((orderId, orderData) {
      loadedOrders.add(
        OrderItem(
          id: orderId,
          amount: orderData['amount'],
          dateTime: DateTime.parse(orderData['datetime']),
          products: (orderData['products'] as List<dynamic>)
              .map(
                (item) => CartItem(
                  id: item['id'],
                  price: item['price'],
                  quantity: item['quantity'],
                  title: item['title'],
                ),
              )
              .toList(),
        ),
      );
    });
    _orders = loadedOrders.reversed.toList();
    print(_orders);
    notifyListeners();
  }

  Future<void> addItem(List<CartItem> cartitems, double total) async {
    final url = Uri.parse(
        'https://athmany-api-default-rtdb.firebaseio.com/orders.json');
    final time = DateTime.now();
    final response = await http.post(
      url,
      body: json.encode({
        'amount': total,
        'datetime': time.toIso8601String(),
        'products': cartitems
            .map(
              (e) => {
                'id': e.id,
                'title': e.title,
                'price': e.price,
                'quantity': e.quantity,
              },
            )
            .toList(),
      }),
    );
    _orders.insert(
      0,
      OrderItem(
        id: json.decode(response.body)['name'],
        amount: total,
        products: cartitems,
        dateTime: DateTime.now(),
      ),
    );
    notifyListeners();
    // SharedPreferences prefs = await SharedPreferences.getInstance();
    // Map<String, dynamic> order = {
    //   'id': DateTime.now().toString() + "1",
    //   'amount': total,
    //   'products': cartitems.toString(),
    //   'datetime': DateTime.now().toString(),
    // };

    // List listOfOrder = [];
    // // listOfOrder.add(OrderItem(
    // //     id: DateTime.now().toString(),
    // //     amount: total,
    // //     products: cartitems,
    // //     dateTime: DateTime.now()));
    // _orders.forEach((element) {
    //   // store values
    //   Map<String, dynamic> ord = {
    //     'id': DateTime.now().toString(),
    //     'amount': total,
    //     'products': cartitems,
    //     'dateTime': DateTime.now(),
    //   };
    //   listOfOrder.add(ord);
    // });
    // print(_orders);
    // print("ddd ${listOfOrder}");
  }
}
