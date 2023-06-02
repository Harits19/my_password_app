import 'package:flutter/material.dart';

class FloatingButtonDrawer extends StatelessWidget {
  const FloatingButtonDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      heroTag: 'floatingButton2',
      onPressed: () {
        // passwordRead.sync();
        // return;
        Scaffold.of(context).openEndDrawer();
      },
      child: Icon(Icons.menu),
    );
  }
}