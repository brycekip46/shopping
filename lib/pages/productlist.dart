import 'package:flutter/material.dart';
import 'package:shopping/main.dart';
import 'package:shopping/data/product.dart';
import 'package:shopping/data/server.dart';

class ProductListWidget extends StatefulWidget {
  const ProductListWidget({super.key});

  @override
  State<ProductListWidget> createState() => ProductListWidgetState();
}

class ProductListWidgetState extends State<ProductListWidget> {
  List<String> get _productList => productList;
  List<String> productList = Server.getProductList();

  set _productList(List<String> value) {
    setState(() {
      productList = value;
    });
  }

  Set<String> get _itemsInCart => itemsInCart;
  Set<String> itemsInCart = <String>{};

  set _itemsInCart(Set<String> value) {
    setState(() {
      itemsInCart = value;
    });
  }

  void handleAddToCart(String id) {
    _itemsInCart = itemsInCart..add(id);
    shoppingcart.currentState!.itemsInCart = _itemsInCart;
  }

  void handleRemoveFromCart(String id) {
    _itemsInCart = itemsInCart..remove(id);
    shoppingcart.currentState!.itemsInCart = _itemsInCart;
  }

  Widget buildProductTile(String id) {
    return ProductTile(
        product: Server.getProductById(id),
        purchased: _itemsInCart.contains(id),
        onAddToCart: () => handleAddToCart(id),
        onRemoveFromCart: () => handleRemoveFromCart(id));
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: productList.map(buildProductTile).toList(),
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
            child: purchased ? Text("remove from cart") : Text("Add to cart"),
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
