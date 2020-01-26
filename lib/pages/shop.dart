import 'package:flutter/material.dart';
import 'package:pokeclicker/classes/coinsManager.dart';

class ShopPage extends StatefulWidget {
  @override
  _ShopPageState createState() => _ShopPageState();
}

class _ShopPageState extends State<ShopPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Shop'),
        centerTitle: true,
      ),
      body: ListView(
        children: <Widget>[
          ListTile(
            title: Text('Increment multiplier by 1'),
            subtitle: Text('Cost: 0'),
            trailing: RaisedButton(
              child: Text('BUY'),
              onPressed: () {
                CoinsManager.setCoins(CoinsManager.coins - 0);
                CoinsManager.setMultiplier(CoinsManager.multiplier + 1);
              },
            ),
          )
        ],
      ),
    );
  }
}
