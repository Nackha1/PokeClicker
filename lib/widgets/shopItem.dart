import 'package:flutter/material.dart';
import 'package:pokeclicker/classes/pokeball.dart';
import 'package:pokeclicker/pages/unbox.dart';

import '../classes/pokeManager.dart';

class ShopItem extends StatelessWidget {
  const ShopItem({this.item});

  final Pokeball item;

  void _showSnackBar(BuildContext context) {
    SnackBar snackBar = SnackBar(
      content: Text("You don't have enough PokeCoins!"),
    );
    Scaffold.of(context).showSnackBar(snackBar);
  }

  void _navigateToUnboxPage(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (BuildContext context) => UnboxPage(
          item: item,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    bool _isLight = item.colors[0].computeLuminance() > 0.5;
    return Padding(
      padding: const EdgeInsets.only(top: 8.0, right: 16.0, bottom: 8.0),
      child: Material(
        type: MaterialType.card,
        elevation: 1,
        borderRadius: BorderRadius.only(
            topRight: Radius.circular(100.0),
            bottomRight: Radius.circular(100.0)),
        clipBehavior: Clip.antiAlias,
        color: item.colors[0],
        child: InkWell(
          onTap: () {
            if (PokeManager.spendCoins(item.cost)) {
              _navigateToUnboxPage(context);
            } else {
              _showSnackBar(context);
            }
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Expanded(
                flex: 2,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Image.asset(
                            'assets/pokecoin_front.png',
                            width: 24,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(2.0),
                          ),
                          Text(
                            '${item.cost}',
                            style: TextStyle(
                              color: _isLight ? Colors.black54 : Colors.white70,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      Text(
                        item.name,
                        style: TextStyle(
                          color: _isLight ? Colors.black54 : Colors.white70,
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'Pokemons x${item.pokemons}',
                        style: TextStyle(
                          color: _isLight ? Colors.black54 : Colors.white70,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Image.asset(
                  item.asset,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
