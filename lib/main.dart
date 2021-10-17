import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:athmany/providers/cart.dart';
import 'package:athmany/providers/products.dart';
import 'package:athmany/providers/orders.dart';
import 'package:athmany/screens/home.dart';
import 'package:athmany/screens/ordersScreen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: Products(),
        ),
        ChangeNotifierProvider.value(
          value: Cart(),
        ),
        ChangeNotifierProvider.value(
          value: Orders(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Home(),
        routes: {
          OrderScreen.routename: (ctx) => OrderScreen(),
        },
      ),
    );
  }
}

class Home extends StatefulWidget {
  // var appbg = Color(0XFF6B9AA0);
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('athman'),
        // Color(0XFF6B9AA0);
        backgroundColor: Color(0XFF354853),
      ),
      body: Center(
        child: Container(
          color: Colors.green,
          child: TextButton(
            onPressed: () {
              Navigator.of(context).push(new MaterialPageRoute(
                builder: (BuildContext context) => FoodCard(),
              ));
            },
            child: Text(
              "Start",
              style: TextStyle(
                fontSize: 40,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
