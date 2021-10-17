import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:athmany/providers/orders.dart';

class OrderItemWidget extends StatelessWidget {
  final OrderItem orderItem;

  const OrderItemWidget(this.orderItem);
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(10),
      child: Column(
        children: [
          ListTile(
            title: Text("${orderItem.amount}"),
            subtitle: Text(
              DateFormat('dd mm yyyy hh:mm').format(orderItem.dateTime),
            ),
          )
        ],
      ),
    );
  }
}
