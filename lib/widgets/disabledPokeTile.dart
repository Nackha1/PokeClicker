import 'package:flutter/material.dart';
import 'package:pokeclicker/classes/pokemon.dart';
import 'package:pokeclicker/classes/typeColors.dart';
import 'package:pokeclicker/globals.dart';

Widget disabledPokeTile(BuildContext context, Pokemon pokemon) {
  TypeColors _pokeColors = pokemonTypeColor[pokemon.type[0]];
  return Padding(
    padding: const EdgeInsets.all(4.0),
    child: Material(
      type: MaterialType.card,
      elevation: 1,
      borderRadius: BorderRadius.all(Radius.circular(16.0)),
      clipBehavior: Clip.antiAlias,
      color: _pokeColors.dark,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: <Widget>[
            Expanded(
              child: Stack(
                alignment: Alignment.bottomCenter,
                children: <Widget>[
                  Align(
                    alignment: Alignment.topRight,
                    child: Text(
                      '#${pokemon.id.toString().padLeft(3, '0')}',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 28,
                        color: Colors.black38,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      '?',
                      style: TextStyle(
                        fontSize: 64,
                        color: Colors.black54,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Text(
                pokemon.name,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: Colors.black54,
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
