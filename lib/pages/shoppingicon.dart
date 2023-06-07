import 'package:flutter/material.dart';

import '../data/appstate.dart';

class ShoppingCartIcon extends StatelessWidget {
  const ShoppingCartIcon({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Set<String> itemsInCart = AppStateScope.of(context).itemsInCart;
    final bool hasPurchase = itemsInCart.isNotEmpty;

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
                itemsInCart.length.toString(),
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
