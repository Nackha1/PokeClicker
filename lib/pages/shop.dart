import 'package:flutter/material.dart';
import 'package:pokeclicker/classes/coinsManager.dart';
import 'package:pokeclicker/widgets/shopItem.dart';

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
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          Expanded(
            child: ShopItem(
              text: 'Pokeball',
              color: Colors.red,
              image: Image.asset('assets/shop/pokeball.png'),
            ),
          ),
          Expanded(
            child: ShopItem(
              text: 'Megaball',
              color: Colors.blue,
              image: Image.asset('assets/shop/megaball.png'),
            ),
          ),
          Expanded(
            child: ShopItem(
              text: 'Ultraball',
              color: Colors.amber,
              image: Image.asset('assets/shop/ultraball.png'),
            ),
          ),
          Expanded(
            // child: Material(
            //   type: MaterialType.card,
            //   elevation: 1,
            //   borderRadius: BorderRadius.all(Radius.circular(8.0)),
            //   clipBehavior: Clip.antiAlias,
            //   color: Colors.deepPurple,
            //   child: Padding(
            //     padding: const EdgeInsets.all(8.0),
            //     child: ListTile(
            //       title: Text('Masterball'),
            //       trailing: Image.asset('assets/shop/masterball.png'),
            //     ),
            //   ),
            // ),
            child: ShopItem(
              text: 'Masterball',
              color: Colors.deepPurple,
              image: Image.asset('assets/shop/masterball.png'),
            ),
          ),
        ],
      ),
    );
  }
}
