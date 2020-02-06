import 'package:flutter/material.dart';
import 'package:pokeclicker/classes/pokeManager.dart';

import '../classes/pokeManager.dart';

class ClickerPage extends StatefulWidget {
  @override
  _ClickerPageState createState() => _ClickerPageState();
}

class _ClickerPageState extends State<ClickerPage>
    with SingleTickerProviderStateMixin {
  Animation _animation;
  AnimationController _animationController;

  @override
  void initState() {
    super.initState();

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
      PokeManager.incrementProgress();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('PokeClicker'),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.info_outline),
          onPressed: () {
            Navigator.pushNamed(context, '/about_me');
          },
        ),
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
            value: PokeManager.progress / 100,
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
                          color: Colors.white,
                          size: 32,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 5,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(Icons.touch_app),
                    Text(
                      '+${PokeManager.getPower() / 100}',
                      style: Theme.of(context).textTheme.title,
                    ),
                  ],
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
                          color: Colors.white,
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
