import 'dart:math';

import 'package:flutter/material.dart';
import 'package:pokeclicker/classes/pokeManager.dart';
import 'package:pokeclicker/classes/pokeball.dart';
import 'package:pokeclicker/globals.dart';

import 'package:pokeclicker/widgets/customShapeClipper.dart';
import 'package:pokeclicker/widgets/pokemonTile.dart';

class UnboxPage extends StatefulWidget {
  const UnboxPage({this.item});

  final Pokeball item;

  @override
  _UnboxPageState createState() => _UnboxPageState();
}

class _UnboxPageState extends State<UnboxPage> with TickerProviderStateMixin {
  List<int> _tempList;
  bool _isLight;
  int _count;
  Animation _rotAnim;
  CurvedAnimation _curvedAnimation;
  AnimationController _rotAnimCont;
  Animation _tapAnim;
  AnimationController _tapAnimCont;

  @override
  void initState() {
    super.initState();

    _tempList = List<int>();
    _isLight = widget.item.colors[0].computeLuminance() > 0.5;
    _count = 0;

    _rotAnimCont = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 500),
    );

    _curvedAnimation = CurvedAnimation(
      parent: _rotAnimCont,
      curve: Curves.easeInOut,
    );
    _rotAnim = Tween<double>(
      begin: pi / 16,
      end: -pi / 16,
    ).animate(_curvedAnimation)
      ..addListener(() {
        setState(() {});
      })
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          _rotAnimCont.reverse();
        } else if (status == AnimationStatus.dismissed) {
          _rotAnimCont.forward();
        }
      });

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
  }

  void _onTap() {
    _tapAnimCont.reset();
    _tapAnimCont.forward();
    if (_count < widget.item.pokemons) {
      _catchRandomPokemon();
    }
    if (_count == widget.item.pokemons) {
      // _rotAnimCont.value = 0.0;
      // _rotAnimCont.dispose();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        brightness: _isLight ? Brightness.light : Brightness.dark,
        title: Text(
          widget.item.name,
          style: TextStyle(
            color: _isLight ? Colors.black54 : Colors.white70,
            fontSize: 32,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: widget.item.colors[0],
        elevation: 0.0,
        iconTheme: IconThemeData(
          color: _isLight ? Colors.black54 : Colors.white70,
        ),
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
          Expanded(
            flex: 2,
            child: GridView.builder(
              padding: const EdgeInsets.all(4.0),
              scrollDirection: Axis.vertical,
              gridDelegate:
                  SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
              itemCount: _tempList.length,
              itemBuilder: (BuildContext context, int index) {
                return buildPokemonTile(context, pokedex[_tempList[index]]);
              },
            ),
          ),
        ],
      ),
      floatingActionButton: _count >= widget.item.pokemons
          ? FloatingActionButton.extended(
              backgroundColor: widget.item.colors[0],
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: Icon(
                Icons.done,
                color: _isLight ? Colors.black54 : Colors.white70,
              ),
              label: Text(
                'DONE',
                style: TextStyle(
                  color: _isLight ? Colors.black54 : Colors.white70,
                ),
              ),
            )
          : null,
    );
  }
}

// class UnboxPokeball extends StatefulWidget {
//   const UnboxPokeball({
//     Key key,
//     @required this.item,
//   }) : super(key: key);

//   final Pokeball item;

//   @override
//   _UnboxPokeballState createState() => _UnboxPokeballState();
// }

// class _UnboxPokeballState extends State<UnboxPokeball>
//     with TickerProviderStateMixin {
//   Animation _rotAnim;
//   CurvedAnimation _curvedAnimation;
//   AnimationController _rotAnimCont;
//   Animation _tapAnim;
//   AnimationController _tapAnimCont;
//   int _count = 0;

//   @override
//   void initState() {
//     super.initState();

//     _count = 0;

//     _rotAnimCont = AnimationController(
//       vsync: this,
//       duration: Duration(milliseconds: 500),
//     );

//     _curvedAnimation = CurvedAnimation(
//       parent: _rotAnimCont,
//       curve: Curves.easeInOut,
//     );
//     _rotAnim = Tween<double>(
//       begin: pi / 16,
//       end: -pi / 16,
//     ).animate(_curvedAnimation)
//       ..addListener(() {
//         setState(() {});
//       })
//       ..addStatusListener((status) {
//         if (status == AnimationStatus.completed) {
//           _rotAnimCont.reverse();
//         } else if (status == AnimationStatus.dismissed) {
//           _rotAnimCont.forward();
//         }
//       });

//     _tapAnimCont = AnimationController(
//       value: 1.0,
//       vsync: this,
//       duration: Duration(milliseconds: 250),
//     );
//     _tapAnim = Tween<double>(begin: 1.1, end: 1.0).animate(_tapAnimCont)
//       ..addListener(() {
//         setState(() {});
//       });

//     _rotAnimCont.forward();
//   }

//   @override
//   void dispose() {
//     _rotAnimCont.dispose();
//     _tapAnimCont.dispose();
//     caughtPokemons.clear();
//     super.dispose();
//   }

//   void _catchRandomPokemon() {
//     _tapAnimCont.reset();
//     _tapAnimCont.forward();
//     if (_count < widget.item.pokemons) {
//       caughtPokemons.add(Random().nextInt(pokedex.length));
//       _count++;
//     }
//     // } else {
//     //   SnackBar snackBar = SnackBar(
//     //     content:
//     //         Text('There are no more Pokemons inside this ${widget.item.name}!'),
//     //     duration: Duration(seconds: 3),
//     //   );
//     //   Scaffold.of(context).showSnackBar(snackBar);
//     // }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: _catchRandomPokemon,
//       child: Transform.rotate(
//         angle: _rotAnim.value,
//         child: Transform.scale(
//           scale: _tapAnim.value,
//           child: Image.asset(
//             widget.item.asset,
//           ),
//         ),
//       ),
//     );
//   }
// }
