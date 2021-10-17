import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:athmany/providers/orders.dart';
import 'package:athmany/widgets/orderItem_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OrderScreen extends StatefulWidget {
  static const routename = '/orders';

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  String displayname;
  Map<String, dynamic> l;
  var data = [];
  getData() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      displayname = preferences.getString('order');
      l = jsonDecode(displayname) as Map<String, dynamic>;
      data.add(l);
      print(data);
    });
  }

  @override
  void initState() {
    getData();
  }

  Widget build(BuildContext context) {
    var ordersData = Provider.of<Orders>(context);
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: Text("الطلبات السابقة"),
          centerTitle: false,
        ),
        body: ListView.builder(
          itemBuilder: (ctx, i) => OrderItemWidget(
            ordersData.orders[i],
          ),
          itemCount: ordersData.orders.length,
        ),
      ),
    );
  }
}
