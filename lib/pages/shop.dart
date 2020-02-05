import 'package:flutter/material.dart';
import 'package:pokeclicker/globals.dart';
import 'package:pokeclicker/widgets/shopItem.dart';

class ShopPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Shop'),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: pokeballs.length,
        itemBuilder: (BuildContext context, int index) {
          return ShopItem(item: pokeballs[index]);
        },
      ),
    );
  }
}
