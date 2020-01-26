import 'dart:convert';

import 'package:draggable_scrollbar/draggable_scrollbar.dart';
import 'package:flutter/material.dart';
import 'package:pokeclicker/classes/pokemon.dart';
import 'package:pokeclicker/widgets/pokemonTile.dart';

class PokedexPage extends StatefulWidget {
  @override
  _PokedexPageState createState() => _PokedexPageState();
}

class _PokedexPageState extends State<PokedexPage> {
  List<Pokemon> pokedex;
  bool _isSortedAlpha;
  ScrollController myScrollController;

  @override
  void initState() {
    super.initState();

    pokedex = List<Pokemon>();
    _isSortedAlpha = false;
    myScrollController = ScrollController();

    fetchData();
  }

  fetchData() async {
    String encodedData =
        await DefaultAssetBundle.of(context).loadString("assets/pokedex.json");
    List<dynamic> decodedJson = jsonDecode(encodedData);

    decodedJson.forEach((item) {
      Pokemon pokemon = Pokemon.fromJson(item);
      setState(() {
        pokedex.add(pokemon);
      });
    });
  }

  void _sort() {
    _isSortedAlpha
        ? pokedex.sort((a, b) => a.id.compareTo(b.id))
        : pokedex.sort((a, b) => a.name.compareTo(b.name));
    setState(() {
      _isSortedAlpha = !_isSortedAlpha;
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
            onPressed: _sort,
            tooltip: 'Increment',
            icon: Icon(_isSortedAlpha ? Icons.sort : Icons.sort_by_alpha),
          )
        ],
      ),
      body: pokedex.isEmpty
          ? Center(
              child: CircularProgressIndicator(),
            )
          : DraggableScrollbar.rrect(
              controller: myScrollController,
              child: GridView.builder(
                padding: const EdgeInsets.all(4.0),
                controller: myScrollController,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2),
                itemCount: pokedex.length,
                itemBuilder: (BuildContext context, int index) {
                  return buildPokemonTile(context, pokedex[index]);
                },
              ),
            ),
    );
  }
}
