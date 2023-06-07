import 'package:flutter/material.dart';
import 'package:shopping/data/appstate.dart';
import 'package:shopping/pages/myStorepage.dart';

void main() {
  runApp(AppStateWidget(
    child: MaterialApp(
      scrollBehavior: ConstantScrollBehavior(),
      debugShowCheckedModeBanner: false,
      title: 'Store',
      home: MYStorePage(),
    ),
  ));
}

class ConstantScrollBehavior extends ScrollBehavior {
  const ConstantScrollBehavior();

  Widget buildScrollbar(
          BuildContext context, Widget child, ScrollableDetails detail) =>
      child;

  Widget buildOverscrollIndicator(
          BuildContext context, Widget child, ScrollableDetails details) =>
      child;
  TargetPlatform getPlatform(BuildContext context) => TargetPlatform.linux;

  ScrollPhysics getScrollPhysics(BuildContext context) =>
      const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics());
}
