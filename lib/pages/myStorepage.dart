import 'package:flutter/material.dart';
import 'package:shopping/main.dart';
import 'package:shopping/data/server.dart';
import 'package:shopping/pages/shoppingicon.dart';
import 'package:shopping/pages/productlist.dart';

class MYStorePage extends StatefulWidget {
  const MYStorePage({super.key});

  @override
  State<MYStorePage> createState() => _MYStorePageState();
}

class _MYStorePageState extends State<MYStorePage> {
  bool inSearch = false;
  final TextEditingController controller = TextEditingController();
  final FocusNode focusNode = FocusNode();

  void toggleSearch() {
    setState(() {
      inSearch = !inSearch;
    });
    controller.clear();
    productList.currentState!.productList = Server.getProductList();
  }

  void handleSearch() {
    focusNode.unfocus();
    final String filter = controller.text;
    productList.currentState!.productList =
        Server.getProductList(filter: filter);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            leading: Padding(
              padding: EdgeInsets.all(10.0),
              child: Image.network('$baseAssetURL/google-logo.png'),
            ),
            title: inSearch
                ? TextField(
                    autofocus: true,
                    focusNode: focusNode,
                    controller: controller,
                    onSubmitted: (_) => handleSearch(),
                    decoration: InputDecoration(
                      hintText: 'Search store',
                      prefixIcon: IconButton(
                          icon: Icon(Icons.search),
                          onPressed: () {
                            handleSearch();
                          }),
                      suffixIcon: IconButton(
                        icon: Icon(Icons.close),
                        onPressed: () {
                          toggleSearch();
                        },
                      ),
                    ),
                  )
                : null,
            actions: [
              if (!inSearch)
                IconButton(
                  icon: Icon(
                    Icons.search,
                    color: Colors.black,
                  ),
                  onPressed: () {
                    toggleSearch();
                  },
                ),
              ShoppingCartIcon(key: shoppingcart),
            ],
            backgroundColor: Colors.white,
            pinned: true,
          ),
          SliverToBoxAdapter(
            child: ProductListWidget(key: productList),
          ),
        ],
      ),
    );
  }
}
