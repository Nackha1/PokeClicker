import 'package:flutter/material.dart';
import 'package:pokeclicker/classes/pokeManager.dart';
import 'package:pokeclicker/classes/typeColors.dart';

class TypeChip extends StatelessWidget {
  TypeChip({this.name});

  final String name;

  @override
  Widget build(BuildContext context) {
    TypeColors typeColor = PokeManager.pokemonTypeColor[name];
    return Chip(
      label: Text(
        name,
        style: TextStyle(color: Colors.black54),
      ),
      elevation: 2.0,
      backgroundColor: typeColor.light,
    );
  }
}
