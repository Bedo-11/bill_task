import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Product with ChangeNotifier {
  String id;
  String name;
  double price;
  String amount;
  String img;
  Product(this.id, this.name, this.price, this.img, {this.amount = "0"});
}

class Products with ChangeNotifier {
  List<Product> _items = [
    Product("1", "برجر", 50, "assets/images/burger.png"),
    Product("2", "بيتزا", 70, "assets/images/pizza.png"),
    Product("3", "برجر", 50, "assets/images/burger.png"),
    Product("4", "بيتزا", 70, "assets/images/pizza.png"),
    Product("5", "برجر", 50, "assets/images/burger.png"),
    Product("6", "بيتزا", 70, "assets/images/pizza.png"),
  ];

  List<Product> get items {
    return [..._items];
  }

  Product findById(String id) {
    return _items.firstWhere((prod) => prod.id == id);
  }
}
