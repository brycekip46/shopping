import 'package:flutter/material.dart';

class ShoppingCartIcon extends StatefulWidget {
  const ShoppingCartIcon({super.key});

  @override
  State<ShoppingCartIcon> createState() => ShoppingCartIconState();
}

class ShoppingCartIconState extends State<ShoppingCartIcon> {
  Set<String> get _itemsInCart => itemsInCart;
  Set<String> itemsInCart = <String>{};

  set _itemsInCart(Set<String> value) {
    setState(() {
      itemsInCart = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    final bool hasPurchase = _itemsInCart.isNotEmpty;
    return Stack(
      alignment: Alignment.center,
      children: [
        Padding(
          padding: EdgeInsets.only(right: hasPurchase ? 17.0 : 10.0),
          child: Icon(
            Icons.shopping_cart,
            color: Colors.black,
          ),
        ),
        if (hasPurchase)
          Padding(
            padding: EdgeInsets.only(left: 17.0),
            child: CircleAvatar(
              backgroundColor: Colors.lightBlue,
              radius: 10,
              foregroundColor: Colors.white,
              child: Text(
                _itemsInCart.length.toString(),
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 12.0,
                ),
              ),
            ),
          ),
      ],
    );
  }
}
