import 'package:draggable_scrollbar/draggable_scrollbar.dart';
import 'package:flutter/material.dart';
import 'package:pokeclicker/classes/pokeManager.dart';
import 'package:pokeclicker/classes/pokemon.dart';
import 'package:pokeclicker/globals.dart';
import 'package:pokeclicker/widgets/pokemonTile.dart';

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
      pokemons.add(pokedex[item]);
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
      pokemons.addAll(pokedex);
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
          style: Theme.of(context).textTheme.title,
        ),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            icon: Icon(
                _isShowingPokedex ? Icons.visibility_off : Icons.visibility),
            onPressed: _show,
            tooltip: 'Show/Hide Pokedex',
          ),
          IconButton(
            icon: Icon(_isSortedAlpha ? Icons.sort : Icons.sort_by_alpha),
            onPressed: _sort,
            tooltip: 'Sort Pokemons',
          ),
        ],
      ),
      body: DraggableScrollbar.rrect(
        controller: myScrollController,
        child: GridView.builder(
          padding: const EdgeInsets.all(4.0),
          controller: myScrollController,
          gridDelegate:
              SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
          itemCount: pokemons.length,
          itemBuilder: (BuildContext context, int index) {
            return buildPokemonTile(context, pokemons[index]);
          },
        ),
      ),
    );
  }
}
