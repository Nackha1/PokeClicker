import 'package:flutter/material.dart';
import 'package:pokeclicker/classes/pokemon.dart';
import 'package:pokeclicker/classes/typeColors.dart';
import 'package:pokeclicker/colors.dart';
import 'package:cached_network_image/cached_network_image.dart';

class Details extends StatefulWidget {
  Details({Key key, this.pokemon}) : super(key: key);

  final Pokemon pokemon;

  @override
  _DetailsState createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  Pokemon pokemon;
  TypeColors colors;

  @override
  void initState() {
    super.initState();

    pokemon = widget.pokemon;
    colors = pokemonTypeColor[pokemon.type[0]];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colors.normal,
      appBar: AppBar(
        title: Text(
          pokemon.name,
          style: Theme.of(context).textTheme.title.copyWith(
                color: colors.normal,
              ),
        ),
        centerTitle: true,
        elevation: 0.0,
        iconTheme: Theme.of(context).iconTheme.copyWith(
              color: colors.normal,
            ),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            flex: 3,
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                borderRadius:
                    BorderRadius.only(bottomLeft: Radius.circular(120.0)),
              ),
              child: Center(
                child: Hero(
                  tag: pokemon.name,
                  /* Important for back compatibility */
                  // child: Image.asset(
                  //   'assets/front/${pokemon.name.toLowerCase().replaceAll(' ', '_')}.gif',
                  //   width: 200,
                  //   fit: BoxFit.contain,
                  // ),
                  child: CachedNetworkImage(
                    placeholder: (context, url) => CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(colors.normal),
                    ),
                    errorWidget: (context, url, error) => Icon(
                      Icons.error,
                      color: Colors.red,
                    ),
                    imageUrl:
                        'https://raw.githubusercontent.com/Nackha1/Hd-sprites/master/${pokemon.name.replaceAll(' ', '_')}.gif',
                    width: 300,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(),
          )
        ],
      ),
    );
  }
}
