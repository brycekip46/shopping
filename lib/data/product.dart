import 'package:flutter/material.dart';

class Product {
  final String id;
  final String pictureURL;
  final String title;
  final TextSpan description;

  const Product(
      {required this.id,
      required this.description,
      required this.pictureURL,
      required this.title});
}
