import 'package:flutter/material.dart';
import 'package:shopping/data/appstate.dart';
import 'package:shopping/data/product.dart';
import 'package:shopping/data/server.dart';

class ProductListWidget extends StatelessWidget {
  const ProductListWidget({Key? key}) : super(key: key);

  void _handleAddToCart(String id, BuildContext context) {
    AppStateWidget.of(context).addToCart(id);
  }

  void _handleRemoveFromCart(String id, BuildContext context) {
    AppStateWidget.of(context).removeFromCart(id);
  }

  Widget _buildProductTile(String id, BuildContext context) {
    return ProductTile(
        product: Server.getProductById(id),
        purchased: AppStateScope.of(context).itemsInCart.contains(id),
        onAddToCart: () => _handleAddToCart(id, context),
        onRemoveFromCart: () => _handleRemoveFromCart(id, context));
  }

  @override
  Widget build(BuildContext context) {
    final List<String> productList = AppStateScope.of(context).productList;

    return Column(
      children:
          productList.map((id) => _buildProductTile(id, context)).toList(),
    );
  }
}

class ProductTile extends StatelessWidget {
  final Product product;
  final bool purchased;
  final VoidCallback onAddToCart;
  final VoidCallback onRemoveFromCart;

  const ProductTile(
      {Key? key,
      required this.product,
      required this.purchased,
      required this.onAddToCart,
      required this.onRemoveFromCart})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color getButtonColor(Set<MaterialState> states) {
      return purchased ? Colors.grey : Colors.black;
    }

    BorderSide getButtonSide(Set<MaterialState> states) {
      return BorderSide(
        color: purchased ? Colors.grey : Colors.black,
      );
    }

    return Container(
      margin: const EdgeInsets.symmetric(
        vertical: 15,
        horizontal: 40,
      ),
      color: Color(0xfff8f8f8),
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Padding(
          padding: const EdgeInsets.all(20),
          child: Text(product.title),
        ),
        Text.rich(
          product.description,
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        Padding(
          padding: EdgeInsets.all(20),
          child: OutlinedButton(
            child: purchased
                ? const Text("remove from cart")
                : Text("Add to cart"),
            style: ButtonStyle(
                foregroundColor: MaterialStateProperty.resolveWith(
                    (states) => getButtonColor(states)),
                side: MaterialStateProperty.resolveWith(
                    (states) => getButtonSide(states))),
            onPressed: purchased ? onRemoveFromCart : onAddToCart,
          ),
        ),
        Image.network(product.pictureURL),
      ]),
    );
  }
}
