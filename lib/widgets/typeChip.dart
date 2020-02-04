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
        style: TextStyle(color: Colors.black54),
      ),
      elevation: 2.0,
      backgroundColor: typeColor.light,
    );
  }
}
