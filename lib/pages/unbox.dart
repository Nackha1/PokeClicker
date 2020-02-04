import 'dart:math';

import 'package:flutter/material.dart';
import 'package:pokeclicker/classes/pokeManager.dart';
import 'package:pokeclicker/classes/pokeball.dart';
import 'package:pokeclicker/globals.dart';
import 'package:pokeclicker/widgets/activePokeTile.dart';

import 'package:pokeclicker/widgets/customShapeClipper.dart';

class UnboxPage extends StatefulWidget {
  const UnboxPage({this.item});

  final Pokeball item;

  @override
  _UnboxPageState createState() => _UnboxPageState();
}

class _UnboxPageState extends State<UnboxPage> with TickerProviderStateMixin {
  List<int> _tempList;
  bool _isDarkColor;
  Color _pageStyleColor;
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
    _isDarkColor = widget.item.colors[0].computeLuminance() < 0.5;
    _pageStyleColor = _isDarkColor ? Colors.white70 : Colors.black54;
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

  void _onTap() {
    if (_count < widget.item.pokemons) {
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
        brightness: _isDarkColor ? Brightness.dark : Brightness.light,
        title: Text(
          widget.item.name,
          style: TextStyle(
            color: _pageStyleColor,
            fontSize: 32,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: widget.item.colors[0],
        elevation: 0.0,
        iconTheme: IconThemeData(color: _pageStyleColor),
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
                  child: GestureDetector(
                    onTap: _onTap,
                    child: Transform.rotate(
                      angle: _rotAnim.value,
                      child: Transform.scale(
                        scale: _tapAnim.value,
                        child: Image.asset(
                          widget.item.asset,
                        ),
                      ),
                    ),
                  ),
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
      //floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: _count >= widget.item.pokemons
          ? FloatingActionButton.extended(
              backgroundColor: widget.item.colors[0],
              onPressed: () => Navigator.of(context).pop(),
              icon: Icon(Icons.done),
              label: Text('DONE'),
            )
          : null,
    );
  }
}
