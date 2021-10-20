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
  var _isLoading = false;
  @override
  void initState() {
    Future.delayed(Duration.zero).then((_) async {
      setState(() {
        _isLoading = true;
      });
      await Provider.of<Orders>(context, listen: false).getOrders();
      setState(() {
        _isLoading = false;
      });
    });
    // Provider.of<Orders>(context, listen: false).getOrders();
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
        body: _isLoading
            ? Center(child: CircularProgressIndicator())
            : ListView.builder(
                itemBuilder: (ctx, i) => OrderItemWidget(
                  ordersData.orders[i],
                ),
                itemCount: ordersData.orders.length,
              ),
      ),
    );
  }
}
