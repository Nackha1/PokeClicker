import 'package:flutter/material.dart';
import 'package:pokeclicker/classes/coinsManager.dart';

class ClickerPage extends StatefulWidget {
  @override
  _ClickerPageState createState() => _ClickerPageState();
}

class _ClickerPageState extends State<ClickerPage>
    with SingleTickerProviderStateMixin {
  Animation _animation;
  AnimationController _animationController;

  int coins = 0;
  int multiplier = 0;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 250),
    );
    _animationController.addListener(() {
      setState(() {});
    });
    _animation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.ease,
    );
    _animation = Tween(begin: 0.95, end: 0.85).animate(_animation);

    _initialize();
  }

  void _initialize() async {
    await CoinsManager.initialize();
    setState(() {});
  }

  void _incrementCounter() async {
    CoinsManager.incrementCoinsByMultiplier();
    _animationController.reset();
    _animationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                          '${CoinsManager.coins}',
                          style: TextStyle(
                            fontSize: 32,
                          ),
                        ),
                        Icon(
                          Icons.attach_money,
                          size: 32,
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: GestureDetector(
                      onTap: _incrementCounter,
                      child: Transform.scale(
                        scale: _animation.value,
                        child: Image.asset(
                          'assets/pokeball.png',
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
                      '+${CoinsManager.multiplier}',
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
