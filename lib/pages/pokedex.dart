import 'package:draggable_scrollbar/draggable_scrollbar.dart';
import 'package:flutter/material.dart';
import 'package:pokeclicker/classes/pokeManager.dart';
import 'package:pokeclicker/classes/pokemon.dart';
import 'package:pokeclicker/widgets/activePokeTile.dart';
import 'package:pokeclicker/widgets/disabledPokeTile.dart';

class PokedexPage extends StatefulWidget {
  @override
  _PokedexPageState createState() => _PokedexPageState();
}

class _PokedexPageState extends State<PokedexPage> {
  bool _isSortedAlpha;
  bool _isShowingPokedex;
  ScrollController myScrollController;
  List<Pokemon> pokemons;

  @override
  void initState() {
    super.initState();

    _isSortedAlpha = false;
    _isShowingPokedex = false;
    myScrollController = ScrollController();
    pokemons = List<Pokemon>();

    _loadCaughtPokemons();
  }

  void _loadCaughtPokemons() {
    PokeManager.caughtPokemons.forEach((item) {
      pokemons.add(PokeManager.pokedex[item]);
    });
    pokemons.sort((a, b) => a.id.compareTo(b.id));
  }

  void _sort() {
    _isSortedAlpha
        ? pokemons.sort((a, b) => a.id.compareTo(b.id))
        : pokemons.sort((a, b) => a.name.compareTo(b.name));
    setState(() {
      _isSortedAlpha = !_isSortedAlpha;
    });
  }

  void _show() {
    pokemons.clear();
    if (_isShowingPokedex) {
      _loadCaughtPokemons();
    } else {
      pokemons.addAll(PokeManager.pokedex);
    }

    _isSortedAlpha
        ? pokemons.sort((a, b) => a.name.compareTo(b.name))
        : pokemons.sort((a, b) => a.id.compareTo(b.id));

    setState(() {
      _isShowingPokedex = !_isShowingPokedex;
      myScrollController.jumpTo(0.0);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Pokedex',
        ),
        centerTitle: true,
        actions: <Widget>[
          PopupMenuButton(
            onSelected: (value) {
              if (value == 'show') {
                _show();
              } else if (value == 'sort') {
                _sort();
              }
            },
            itemBuilder: (BuildContext context) {
              return <PopupMenuEntry<dynamic>>[
                CheckedPopupMenuItem(
                  checked: _isSortedAlpha,
                  child: Text('Sort alphabetically'),
                  value: 'sort',
                ),
                CheckedPopupMenuItem(
                  checked: _isShowingPokedex,
                  enabled: true,
                  child: Text('Show all'),
                  value: 'show',
                ),
              ];
            },
          ),
        ],
      ),
      body: DraggableScrollbar.rrect(
        controller: myScrollController,
        child: GridView.builder(
          padding: const EdgeInsets.all(4.0),
          controller: myScrollController,
          itemCount: pokemons.length,
          gridDelegate:
              SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
          itemBuilder: (BuildContext context, int index) {
            if (PokeManager.caughtPokemons.contains(pokemons[index].id - 1)) {
              return activePokeTile(context, pokemons[index]);
            } else {
              return disabledPokeTile(context, pokemons[index]);
            }
          },
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: null,
        label: Text(
            '${PokeManager.caughtPokemons.length}/${PokeManager.pokedex.length}'),
      ),
    );
  }
}
