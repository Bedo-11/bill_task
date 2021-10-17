import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'cart.dart';

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
}

class Orders with ChangeNotifier {
  List<OrderItem> _orders = [];
  List<OrderItem> get orders {
    return [..._orders];
  }

  void addItem(List<CartItem> cartitems, double total) async {
    _orders.insert(
      0,
      OrderItem(
        id: DateTime.now().toString(),
        amount: total,
        products: cartitems,
        dateTime: DateTime.now(),
      ),
    );
    notifyListeners();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    Map<String, dynamic> order = {
      'id': DateTime.now().toString(),
      'amount': total,
      'products': total,
      'datetime': DateTime.now().toString(),
    };

    bool result = await prefs.setString('order', jsonEncode(order));
    print(result);
  }
}
