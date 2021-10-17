import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:athmany/providers/cart.dart';
import 'package:athmany/providers/products.dart';

class ProductItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final product = Provider.of<Product>(context);
    final cart = Provider.of<Cart>(context, listen: false);
    return InkWell(
      onTap: () {
        print("Ff");
        cart.addItem(product.id, product.price, product.name);
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: GridTile(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Image.asset(
              product.img,
              fit: BoxFit.cover,
            ),
          ),
          footer: ClipRRect(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(20),
              bottomRight: Radius.circular(20),
            ),
            child: GridTileBar(
              backgroundColor: Colors.white,
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    product.name,
                    style: TextStyle(
                      color: Colors.blueGrey,
                      fontSize: 25,
                    ),
                  ),
                  Text(
                    product.price.toString(),
                    style: TextStyle(
                      color: Colors.blueGrey,
                      fontSize: 25,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
