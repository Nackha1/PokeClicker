import 'dart:math';

import 'package:flutter/material.dart';
import 'package:pokeclicker/classes/pokeManager.dart';

class ClickerPage extends StatefulWidget {
  @override
  _ClickerPageState createState() => _ClickerPageState();
}

class _ClickerPageState extends State<ClickerPage>
    with SingleTickerProviderStateMixin {
  Animation _animation;
  AnimationController _animationController;

  int _pokeballLife;
  int _power;
  //Color _backgroundColor;

  @override
  void initState() {
    super.initState();

    _pokeballLife = 0;
    _power = 10;
    //_backgroundColor = _randomColor();

    _animationController = AnimationController(
      value: 0.95,
      vsync: this,
      duration: Duration(milliseconds: 250),
    );
    _animation =
        Tween<double>(begin: 0.95, end: 0.85).animate(_animationController)
          ..addListener(() {
            setState(() {});
          });
  }

  void _onTap() {
    _animationController.reset();
    _animationController.forward();
    setState(() {
      _pokeballLife += _power;
      if (_pokeballLife >= 100) {
        PokeManager.incrementCoinsByMultiplier();
        _pokeballLife = 0;
        //_backgroundColor = _randomColor();
      }
    });
  }

  // Color _randomColor() => pokemonTypeColor[pokemonTypeColor.keys
  //         .elementAt(Random().nextInt(pokemonTypeColor.length))]
  //     .light;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: _backgroundColor,
      appBar: AppBar(
        title: Text('PokeClicker'),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, '/settings');
            },
            icon: Icon(Icons.settings),
          )
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          LinearProgressIndicator(
            value: (_pokeballLife / 100),
          ),
          Expanded(
            child: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    flex: 1,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          '${PokeManager.coins}',
                          style: TextStyle(
                            fontSize: 64,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                        ),
                        Image.asset(
                          'assets/pokecoin_front.png',
                          width: 64,
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: GestureDetector(
                      onTap: _onTap,
                      child: Transform.scale(
                        scale: _animation.value,
                        child: Image.asset(
                          'assets/pokeball_click.png',
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Row(
            children: <Widget>[
              Expanded(
                flex: 2,
                child: Material(
                  type: MaterialType.button,
                  color: Colors.blue,
                  elevation: 2.0,
                  clipBehavior: Clip.antiAlias,
                  borderRadius:
                      BorderRadius.only(topRight: Radius.circular(32.0)),
                  child: InkWell(
                    onTap: () {
                      Navigator.pushNamed(context, '/shop');
                    },
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Icon(
                          Icons.shopping_cart,
                          color: Colors.white70,
                          size: 32,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 5,
                child: Container(
                  child: Center(
                    child: Text(
                      '+${PokeManager.multiplier}',
                      style: Theme.of(context).textTheme.title,
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: Material(
                  type: MaterialType.button,
                  color: Colors.red,
                  elevation: 2.0,
                  clipBehavior: Clip.antiAlias,
                  borderRadius:
                      BorderRadius.only(topLeft: Radius.circular(32.0)),
                  child: InkWell(
                    onTap: () {
                      Navigator.pushNamed(context, '/pokedex');
                    },
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Icon(
                          Icons.menu,
                          color: Colors.white70,
                          size: 32,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
