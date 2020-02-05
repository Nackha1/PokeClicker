import 'dart:math';

import 'package:flutter/material.dart';
import 'package:pokeclicker/classes/pokeManager.dart';
import 'package:pokeclicker/classes/pokeball.dart';
import 'package:pokeclicker/globals.dart';
import 'package:pokeclicker/widgets/activePokeTile.dart';

import 'package:pokeclicker/widgets/customShapeClipper.dart';

class UnboxPage extends StatefulWidget {
  const UnboxPage({this.item, this.isDarkColor, this.pageStyleColor});

  final Pokeball item;
  final bool isDarkColor;
  final Color pageStyleColor;

  @override
  _UnboxPageState createState() => _UnboxPageState();
}

class _UnboxPageState extends State<UnboxPage> with TickerProviderStateMixin {
  List<int> _tempList;
  int _count;
  double _tileSize;
  ScrollController _scrollController;
  Animation _rotAnim;
  CurvedAnimation _curvedAnimation;
  AnimationController _rotAnimCont;
  Animation _tapAnim;
  AnimationController _tapAnimCont;
  AnimationStatusListener _rotStatusList;

  @override
  void initState() {
    super.initState();

    _tempList = List<int>();
    _count = 0;
    _scrollController = ScrollController();

    _rotAnimCont = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 500),
    );

    _curvedAnimation = CurvedAnimation(
      parent: _rotAnimCont,
      curve: Curves.easeInOut,
    );
    _rotStatusList = (status) {
      if (status == AnimationStatus.completed) {
        _rotAnimCont.reverse();
      } else if (status == AnimationStatus.dismissed) {
        _rotAnimCont.forward();
      }
    };
    _rotAnim = Tween<double>(
      begin: pi / 16,
      end: -pi / 16,
    ).animate(_curvedAnimation)
      ..addListener(() {
        setState(() {});
      })
      ..addStatusListener(_rotStatusList);

    _tapAnimCont = AnimationController(
      value: 1.0,
      vsync: this,
      duration: Duration(milliseconds: 250),
    );
    _tapAnim = Tween<double>(begin: 1.1, end: 1.0).animate(_tapAnimCont)
      ..addListener(() {
        setState(() {});
      });

    _rotAnimCont.forward();
  }

  @override
  void dispose() {
    _rotAnimCont.dispose();
    _tapAnimCont.dispose();
    _tempList.forEach((item) {
      PokeManager.addPokemon(item);
    });
    super.dispose();
  }

  void _catchRandomPokemon() {
    int index;
    do {
      index = Random().nextInt(pokedex.length);
    } while (PokeManager.caughtPokemons.contains(index) ||
        _tempList.contains(index));
    _tempList.add(index);
    _count++;

    _scrollController.animateTo((_count - 1) * _tileSize,
        duration: Duration(milliseconds: 250), curve: Curves.easeInOut);
  }

  void _showSnackBar(BuildContext context) {
    SnackBar snackBar = SnackBar(
      content: Text(
          "You don't have enough PokeCoins [${PokeManager.coins}/${widget.item.cost}]"),
      action: SnackBarAction(label: 'OK', onPressed: () {}),
    );
    Scaffold.of(context).removeCurrentSnackBar();
    Scaffold.of(context).showSnackBar(snackBar);
  }

  void _onTap(BuildContext context) {
    if (_count == 0 && !PokeManager.spendCoins(widget.item.cost)) {
      _showSnackBar(context);
    } else if (_count < widget.item.pokemons) {
      _tapAnimCont.reset();
      _tapAnimCont.forward();
      _catchRandomPokemon();
    }
    if (_count == widget.item.pokemons) {
      _rotAnimCont.removeStatusListener(_rotStatusList);
      _rotAnimCont.value = 0.5;
    }
  }

  @override
  Widget build(BuildContext context) {
    _tileSize = MediaQuery.of(context).size.height / 4;
    return Scaffold(
      appBar: AppBar(
        brightness: widget.isDarkColor ? Brightness.dark : Brightness.light,
        title: Text(
          widget.item.name,
          style: TextStyle(
            color: widget.pageStyleColor,
            fontSize: 32,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: widget.item.colors[0],
        elevation: 0.0,
        iconTheme: IconThemeData(color: widget.pageStyleColor),
      ),
      body: Column(
        children: <Widget>[
          Flexible(
            child: Stack(
              alignment: Alignment.topCenter,
              children: <Widget>[
                ClipPath(
                  clipper: CustomShapeClipper(),
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: widget.item.colors,
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Builder(builder: (myContext) {
                    return GestureDetector(
                      onTap: () {
                        _onTap(myContext);
                      },
                      child: Transform.rotate(
                        angle: _rotAnim.value,
                        child: Transform.scale(
                          scale: _tapAnim.value,
                          child: Image.asset(
                            widget.item.asset,
                          ),
                        ),
                      ),
                    );
                  }),
                ),
              ],
            ),
          ),
          Flexible(
            child: Center(
              child: SizedBox(
                height: _tileSize,
                child: GridView.builder(
                  padding: const EdgeInsets.all(4.0),
                  controller: _scrollController,
                  scrollDirection: Axis.horizontal,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 1),
                  itemCount: _tempList.length,
                  itemBuilder: (BuildContext context, int index) {
                    return activePokeTile(context, pokedex[_tempList[index]]);
                  },
                ),
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: _count >= widget.item.pokemons
          ? FloatingActionButton.extended(
              backgroundColor: widget.item.colors[0],
              onPressed: () => Navigator.of(context).pop(),
              icon: Icon(
                Icons.done,
                color: widget.pageStyleColor,
              ),
              label: Text(
                'DONE',
                style: TextStyle(
                  color: widget.pageStyleColor,
                ),
              ),
            )
          : null,
    );
  }
}
