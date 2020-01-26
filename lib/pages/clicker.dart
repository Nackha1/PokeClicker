import 'package:flutter/material.dart';

class ClickerPage extends StatefulWidget {
  @override
  _ClickerPageState createState() => _ClickerPageState();
}

class _ClickerPageState extends State<ClickerPage>
    with SingleTickerProviderStateMixin {
  int _coins = 0;
  int _multiplier = 1;

  Animation _animation;
  AnimationController _animationController;

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
  }

  void _tap() {
    setState(() {
      _coins += _multiplier;
      _animationController.reset();
      _animationController.forward();
    });
  }

  @override
  void dispose() {
    super.dispose();
    _animationController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('PokeClicker'),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Expanded(
            //flex: 10,
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
                          '$_coins',
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
                      onTap: _tap,
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
              Expanded(
                flex: 5,
                child: Container(),
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
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Icon(
                        Icons.list,
                        color: Colors.white70,
                        size: 32,
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
