import 'package:flutter/material.dart';
import 'package:pokeclicker/classes/typeColors.dart';
import 'package:pokeclicker/globals.dart';

class TypeChip extends StatelessWidget {
  TypeChip({this.name});

  final String name;

  @override
  Widget build(BuildContext context) {
    TypeColors typeColor = pokemonTypeColor[name];
    return Chip(
      label: Text(
        name,
        style: TextStyle(color: typeColor.dark),
      ),
      elevation: 2,
      backgroundColor: typeColor.light,
    );
  }
}
