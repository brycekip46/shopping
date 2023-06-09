import 'package:flutter/widgets.dart';
import 'package:shopping/data/server.dart';

class AppState {
  final List<String> productList;
  final Set<String> itemsInCart;

  AppState({
    required this.productList,
    this.itemsInCart = const <String>{},
  });

  AppState copyWith({
    List<String>? productList,
    Set<String>? itemsInCart,
  }) {
    return AppState(
      productList: productList ?? this.productList,
      itemsInCart: itemsInCart ?? this.itemsInCart,
    );
  }

  bool isInCart(String productId) {
    return itemsInCart.contains(productId);
  }
}

class AppStateScope extends InheritedWidget {
  final AppState data;

  const AppStateScope(this.data, {Key? key, required Widget child})
      : super(key: key, child: child);

  static AppState of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<AppStateScope>()!.data;
  }

  @override
  bool updateShouldNotify(AppStateScope oldWidget) {
    // TODO: implement updateShouldNotify
    return data != oldWidget.data;
  }
}

class AppStateWidget extends StatefulWidget {
  const AppStateWidget({super.key, required this.child});
  final Widget child;

  static AppStateWidgetState of(BuildContext context) {
    return context.findAncestorStateOfType<AppStateWidgetState>()!;
  }

  @override
  AppStateWidgetState createState() => AppStateWidgetState();
}

class AppStateWidgetState extends State<AppStateWidget> {
  AppState data = AppState(
    productList: Server.getProductList(),
  );

  void setProductList(List<String> newProductList) {
    if (newProductList != data.productList) {
      setState(() {
        data = data.copyWith(
          productList: newProductList,
        );
      });
    }
  }

  void addToCart(String id) {
    if (!data.itemsInCart.contains(id)) {
      final Set<String> newItemsInCart = Set<String>.from(data.itemsInCart);
      newItemsInCart.add(id);
      setState(() {
        data = data.copyWith(itemsInCart: newItemsInCart);
      });
    }
  }

  void removeFromCart(String id) {
    if (data.itemsInCart.contains(id)) {
      final Set<String> newItemsICart = Set<String>.from(data.itemsInCart);
      newItemsICart.remove(id);
      setState(() {
        data = data.copyWith(itemsInCart: newItemsICart);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return AppStateScope(
      data,
      child: widget.child,
    );
  }
}
