import 'package:flutter/material.dart';
import 'package:pokeclicker/classes/pokeManager.dart';
import 'package:pokeclicker/classes/pokemon.dart';
import 'package:pokeclicker/classes/typeColors.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:pokeclicker/widgets/typeChip.dart';

class DetailsPage extends StatefulWidget {
  DetailsPage({Key key, this.pokemon}) : super(key: key);

  final Pokemon pokemon;

  @override
  _DetailsPageState createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  Pokemon _pokemon;
  TypeColors _pokeColors;
  bool _isLight;

  TextStyle _attributeNameStyle;
  TextStyle _attributeValueStyle;

  @override
  void initState() {
    super.initState();

    _pokemon = widget.pokemon;
    _pokeColors = PokeManager.pokemonTypeColor[_pokemon.type[0]];
    _isLight = _pokeColors.light.computeLuminance() > 0.5;
    _attributeNameStyle = new TextStyle(
      color: _isLight ? Colors.black54 : Colors.white70,
      fontSize: 16,
      fontWeight: FontWeight.bold,
    );
    _attributeValueStyle = new TextStyle(
      color: _isLight ? Colors.black54 : Colors.white70,
      fontSize: 32,
      fontWeight: FontWeight.bold,
    );
  }

  @override
  Widget build(BuildContext context) {
    var _height =
        num.tryParse(_pokemon.height.substring(0, _pokemon.height.length - 2))
            ?.toDouble();
    print(_height);
    return Scaffold(
      backgroundColor: _pokeColors.normal,
      appBar: AppBar(
        title: Text(
          _pokemon.name,
          style: TextStyle(
            color: _pokeColors.normal,
          ),
        ),
        centerTitle: true,
        elevation: 0.0,
        iconTheme: IconThemeData(
          color: _pokeColors.normal,
        ),
      ),
      body: Column(
        children: <Widget>[
          Flexible(
            flex: 2,
            child: Material(
              elevation: 4.0,
              color: Theme.of(context).primaryColor,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(100.0),
              ),
              child: Center(
                child: Hero(
                  tag: _pokemon.name,
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
                    alignment: Alignment.bottomCenter,
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
      return TypeChip(name: list[index]);
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
