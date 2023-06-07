import 'package:flutter/material.dart';
import 'package:shopping/data/appstate.dart';
import 'package:shopping/data/server.dart';
import 'package:shopping/pages/shoppingicon.dart';
import 'package:shopping/pages/productlist.dart';

class MYStorePage extends StatefulWidget {
  const MYStorePage({super.key});

  @override
  MYStorePageState createState() => MYStorePageState();
}

class MYStorePageState extends State<MYStorePage> {
  bool inSearch = false;
  final TextEditingController controller = TextEditingController();
  final FocusNode focusNode = FocusNode();

  void toggleSearch(BuildContext context) {
    setState(() {
      inSearch = !inSearch;
    });
    AppStateWidget.of(context).setProductList(Server.getProductList());
    controller.clear();
  }

  void handleSearch(BuildContext context) {
    focusNode.unfocus();
    final String filter = controller.text;
    AppStateWidget.of(context)
        .setProductList(Server.getProductList(filter: filter));
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
                    onSubmitted: (_) => handleSearch(context),
                    decoration: InputDecoration(
                      hintText: 'Search store',
                      prefixIcon: IconButton(
                          icon: Icon(Icons.search),
                          onPressed: () {
                            handleSearch(context);
                          }),
                      suffixIcon: IconButton(
                        icon: Icon(Icons.close),
                        onPressed: () {
                          toggleSearch(context);
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
                    toggleSearch(context);
                  },
                ),
              ShoppingCartIcon(),
            ],
            backgroundColor: Colors.white,
            pinned: true,
          ),
          const SliverToBoxAdapter(
            child: ProductListWidget(),
          ),
        ],
      ),
    );
  }
}
