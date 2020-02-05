import 'package:flutter/material.dart';
import 'package:pokeclicker/classes/pokeball.dart';
import 'package:pokeclicker/pages/unbox.dart';

class ShopItem extends StatelessWidget {
  const ShopItem({this.item});

  final Pokeball item;

  void _navigateToUnboxPage(
      BuildContext context, bool _isDarkColor, Color _pageStyleColor) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (BuildContext context) => UnboxPage(
          item: item,
          isDarkColor: _isDarkColor,
          pageStyleColor: _pageStyleColor,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    bool _isDarkColor = item.colors[0].computeLuminance() < 0.5;
    Color _pageStyleColor = _isDarkColor ? Colors.white70 : Colors.black54;
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
            _navigateToUnboxPage(context, _isDarkColor, _pageStyleColor);
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
                              color: _pageStyleColor,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      Text(
                        item.name,
                        style: TextStyle(
                          color: _pageStyleColor,
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'Pokemons x${item.pokemons}',
                        style: TextStyle(
                          color: _pageStyleColor,
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
