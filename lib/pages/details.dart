import 'package:flutter/material.dart';
import 'package:pokeclicker/classes/pokemon.dart';
import 'package:pokeclicker/classes/typeColors.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:pokeclicker/globals.dart';

class DetailsPage extends StatefulWidget {
  DetailsPage({Key key, this.pokemon}) : super(key: key);

  final Pokemon pokemon;

  @override
  _DetailsPageState createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  Pokemon _pokemon;
  TypeColors _pokeColors;

  TextStyle _attributeNameStyle;
  TextStyle _attributeValueStyle;

  @override
  void initState() {
    super.initState();

    _pokemon = widget.pokemon;
    _pokeColors = pokemonTypeColor[_pokemon.type[0]];
    _attributeNameStyle = new TextStyle(
      color: Colors.white70,
      fontSize: 16,
      fontWeight: FontWeight.bold,
    );
    _attributeValueStyle = new TextStyle(
      color: Colors.white70,
      fontSize: 32,
      fontWeight: FontWeight.bold,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _pokeColors.normal,
      appBar: AppBar(
        title: Text(
          _pokemon.name,
          style: Theme.of(context).textTheme.title.copyWith(
                color: _pokeColors.normal,
              ),
        ),
        centerTitle: true,
        elevation: 0.0,
        iconTheme: Theme.of(context).iconTheme.copyWith(
              color: _pokeColors.normal,
            ),
      ),
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Flexible(
            flex: 2,
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(100.0),
                ),
              ),
              child: Center(
                child: Hero(
                  tag: _pokemon.name,
                  /* Important for back compatibility */
                  // child: Image.asset(
                  //   'assets/front/${pokemon.name.toLowerCase().replaceAll(' ', '_')}.gif',
                  //   width: 200,
                  //   fit: BoxFit.contain,
                  // ),
                  child: CachedNetworkImage(
                    placeholder: (context, url) => CircularProgressIndicator(
                      valueColor:
                          AlwaysStoppedAnimation<Color>(_pokeColors.normal),
                    ),
                    errorWidget: (context, url, error) => Icon(
                      Icons.error,
                      color: Colors.red,
                    ),
                    imageUrl:
                        'https://raw.githubusercontent.com/Nackha1/Hd-sprites/master/${_pokemon.name.replaceAll(' ', '_')}.gif',
                    width: 250,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ),
          ),
          Flexible(
            flex: 2,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Flexible(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        _buildChipsAttribute('TYPES', _pokemon.type),
                        _buildChipsAttribute('WEAKNESSES', _pokemon.weaknesses),
                      ],
                    ),
                  ),
                  Flexible(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        _buildStringAttribute('HEIGHT', _pokemon.height),
                        _buildStringAttribute('WEIGHT', _pokemon.weight),
                      ],
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildStringAttribute(String name, String val) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Text(
          name,
          style: _attributeNameStyle,
        ),
        Text(
          val,
          style: _attributeValueStyle,
        ),
      ],
    );
  }

  Widget _buildChipsAttribute(String name, List<String> list) {
    List<Widget> _chips = List.generate(list.length, (index) {
      TypeColors typeColor = pokemonTypeColor[list[index]];
      return Chip(
        label: Text(
          list[index],
          style: TextStyle(color: typeColor.dark),
        ),
        elevation: 2,
        backgroundColor: typeColor.light,
      );
    });

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Text(
          name,
          style: _attributeNameStyle,
        ),
        Flexible(
          child: Wrap(
            spacing: 4,
            runSpacing: -8,
            alignment: WrapAlignment.center,
            children: _chips,
          ),
        )
      ],
    );
  }
}
