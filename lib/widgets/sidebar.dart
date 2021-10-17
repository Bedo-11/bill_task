import 'package:flutter/material.dart';
import 'package:athmany/screens/ordersScreen.dart';

class SideBarWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 0,
      child: Container(
        color: Color(0XFf6CBF9B),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              InkWell(
                child: Icon(
                  Icons.home,
                  size: 60,
                  color: Colors.white,
                ),
              ),
              SizedBox(
                height: 30,
              ),
              InkWell(
                onTap: () {
                  // OrderScreen
                  // Navigator.of(context)
                  //     .pushReplacementNamed(OrderScreen.routename);
                  Navigator.of(context).push(
                    new MaterialPageRoute(
                        builder: (BuildContext context) => new OrderScreen()),
                  );
                },
                child: Icon(
                  Icons.shopping_cart,
                  size: 60,
                  color: Colors.white,
                ),
              ),
              SizedBox(
                height: 30,
              ),
              InkWell(
                child: Icon(
                  Icons.home,
                  size: 60,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
