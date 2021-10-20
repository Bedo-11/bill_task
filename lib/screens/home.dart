import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:ui' as ui;

import 'package:provider/provider.dart';
import 'package:athmany/providers/cart.dart';
import 'package:athmany/providers/orders.dart';
import 'package:athmany/widgets/cart_widget.dart';
import 'package:athmany/widgets/products_grid.dart';
import 'package:athmany/widgets/sidebar.dart';
import 'ordersScreen.dart';

class FoodCard extends StatefulWidget {
  @override
  _FoodCardState createState() => _FoodCardState();
}

class _FoodCardState extends State<FoodCard> {
  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;
    var cart = Provider.of<Cart>(context);
    return MaterialApp(
      home: Scaffold(
        appBar: AppBarWidget(context),
        bottomNavigationBar: BottomBar(cart, context),
        body: Directionality(
          textDirection: TextDirection.rtl,
          child: Container(
            color: Colors.grey,
            child: Row(
              children: [
                // side bar
                SideBarWidget(),
                // Content
                Expanded(
                  flex: 9,
                  child: Column(
                    children: [
                      // App Bar white ,
                      BreadCrumb_searchBar(),
                      Expanded(
                        child: Container(
                          child: Row(
                            children: [
                              ItemsContainer3(),
                              CartContainer(),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  // BreadCrumb and Search bar
  Expanded BreadCrumb_searchBar() {
    return Expanded(
      flex: 0,
      child: Container(
        height: 100,
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 50),
          child: Row(
            children: [
              Row(
                children: [
                  Text(
                    "الطاولات ",
                    style: TextStyle(fontSize: 35),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Icon(
                      Icons.arrow_forward_ios,
                    ),
                  ),
                  Text(
                    "طاولة ١",
                    style: TextStyle(fontSize: 35),
                  )
                ],
              ),
              Row(
                children: [
                  Column(
                    children: [],
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  // app bar
  AppBar AppBarWidget(BuildContext context) {
    return AppBar(
      centerTitle: false,
      backgroundColor: Color(0XFF354853),
      actions: [
        Padding(
          padding: EdgeInsets.only(
            left: 20,
            right: 30,
          ),
          child: InkWell(
            onTap: () {
              Navigator.of(context).pop(false);
            },
            child: Icon(Icons.arrow_forward_sharp),
          ),
        ),
      ],
      title: Text("فاتورة PSO "),
    );
  }

  // bottom bar
  Directionality BottomBar(Cart cart, BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Container(
        color: Color(0xff263239),
        height: 100,
        child: Row(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 50),
                child: Row(
                  children: [
                    Text(
                      "فاتورة ١ ",
                      style: TextStyle(color: Colors.white, fontSize: 25),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Text(
                      "العميل محمد",
                      style: TextStyle(color: Colors.white, fontSize: 25),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              width: 20,
            ),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  CustomButtonWidget(
                    title: 'حفظ',
                    color: Color(0xff84C38C),
                    cart: cart,
                  ),
                  CustomButtonWidget(
                    title: 't',
                    color: Color(0xff84C38C),
                    cart: cart,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // button

  Expanded ItemsContainer3() {
    return Expanded(
        flex: 2,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 30),
          child: ProductsGrid(),
        ));
  }
}

class CustomButtonWidget extends StatefulWidget {
  final Cart cart;
  final Color color;
  final String title;
  // final VoidCallback func;

  const CustomButtonWidget({this.title, this.cart, this.color});

  @override
  State<CustomButtonWidget> createState() => _CustomButtonWidgetState();
}

class _CustomButtonWidgetState extends State<CustomButtonWidget> {
  var _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color>(widget.color),
        padding: MaterialStateProperty.all(
          EdgeInsets.fromLTRB(40, 10, 40, 10),
        ),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18.0),
          ),
        ),
      ),
      onPressed: () async {
        setState(() {
          _isLoading = true;
        });
        if (widget.cart.items.isEmpty) {
          print("its empty!");
        } else {
          await Provider.of<Orders>(context, listen: false).addItem(
              widget.cart.items.values.toList(), widget.cart.totalAmount);
          setState(() {
            _isLoading = false;
          });
          widget.cart.clearCart();
        }
      },
      child: Text(
        widget.title,
        style: TextStyle(color: Colors.white, fontSize: 30),
      ),
    );
  }
}

//
// (widget.cart.totalAmount <= 0 || _isLoading)
// ? null
// :
