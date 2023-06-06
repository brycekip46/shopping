import 'package:flutter/material.dart';
import 'package:shopping/pages/myStorepage.dart';
import 'package:shopping/pages/shoppingicon.dart';
import 'package:shopping/pages/productlist.dart';

final GlobalKey<ShoppingCartIconState> shoppingcart =
    GlobalKey<ShoppingCartIconState>();
final GlobalKey<ProductListWidgetState> productList =
    GlobalKey<ProductListWidgetState>();

void main() {
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'Store',
    home: MYStorePage(),
  ));
}
