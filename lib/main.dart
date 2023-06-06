import 'package:flutter/material.dart';

final GlobalKey<ShoppingCartIconState> shoppingcart =
    GlobalKey<ShoppingCartIconState>();
final GlobalKey<ProductListWidgetState> productList =
    GlobalKey<ProductListWidgetState>();

void main() {
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'Store',
    home: MyStorePage(),
  ));
}
