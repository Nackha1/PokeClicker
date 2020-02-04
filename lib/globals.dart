import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:pokeclicker/classes/pokeball.dart';
import 'package:pokeclicker/classes/pokemon.dart';
import 'package:pokeclicker/classes/typeColors.dart';

List<Pokemon> pokedex = List<Pokemon>();

Future<void> loadPokedex(BuildContext context) async {
  String encodedData =
      await DefaultAssetBundle.of(context).loadString("assets/pokedex.json");
  List<dynamic> decodedJson = jsonDecode(encodedData);

  pokedex.clear();

  decodedJson.forEach((item) {
    Pokemon pokemon = Pokemon.fromJson(item);
    pokedex.add(pokemon);
  });
}

List<Pokeball> pokeballs = [
  Pokeball(
    name: 'Pokeball',
    colors: [Colors.red, Colors.red[900]],
    asset: 'assets/shop/pokeball.png',
    pokemons: 1,
    cost: 10,
  ),
  Pokeball(
    name: 'Megaball',
    colors: [Colors.blue, Colors.blue[900]],
    asset: 'assets/shop/megaball.png',
    pokemons: 3,
    cost: 30,
  ),
  Pokeball(
    name: 'Ultraball',
    colors: [Colors.amber, Colors.amber[900]],
    asset: 'assets/shop/ultraball.png',
    pokemons: 5,
    cost: 50,
  ),
  Pokeball(
    name: 'Masterball',
    colors: [Colors.deepPurple, Colors.deepPurple[900]],
    asset: 'assets/shop/masterball.png',
    pokemons: 1,
    cost: 25,
  ),
];

Map<String, TypeColors> pokemonTypeColor = {
  'Bug': TypeColors(
    light: Color(0xFFC6D16E),
    normal: Color(0xFFA8B820),
    dark: Color(0xFF6D7815),
  ),
  'Dark': TypeColors(
    light: Color(0xFFA29288),
    normal: Color(0xFF705848),
    dark: Color(0xFF49392F),
  ),
  'Dragon': TypeColors(
    light: Color(0xFFA27DFA),
    normal: Color(0xFF7038F8),
    dark: Color(0xFF4924A1),
  ),
  'Electric': TypeColors(
    light: Color(0xFFFAE078),
    normal: Color(0xFFF8D030),
    dark: Color(0xFFA1871F),
  ),
  'Fairy': TypeColors(
    light: Color(0xFFF4BDC9),
    normal: Color(0xFFEE99AC),
    dark: Color(0xFF9B6470),
  ),
  'Fighting': TypeColors(
    light: Color(0xFFD67873),
    normal: Color(0xFFC03028),
    dark: Color(0xFF7D1F1A),
  ),
  'Fire': TypeColors(
    light: Color(0xFFF5AC78),
    normal: Color(0xFFF08030),
    dark: Color(0xFF9C531F),
  ),
  'Flying': TypeColors(
    light: Color(0xFFC6B7F5),
    normal: Color(0xFFA890F0),
    dark: Color(0xFF6D5E9C),
  ),
  'Ghost': TypeColors(
    light: Color(0xFFA292BC),
    normal: Color(0xFF705898),
    dark: Color(0xFF493963),
  ),
  'Grass': TypeColors(
    light: Color(0xFFA7DB8D),
    normal: Color(0xFF78C850),
    dark: Color(0xFF4E8234),
  ),
  'Ground': TypeColors(
    light: Color(0xFFEBD69D),
    normal: Color(0xFFE0C068),
    dark: Color(0xFF927D44),
  ),
  'Ice': TypeColors(
    light: Color(0xFFBCE6E6),
    normal: Color(0xFF98D8D8),
    dark: Color(0xFF638D8D),
  ),
  'Normal': TypeColors(
    light: Color(0xFFC6C6A7),
    normal: Color(0xFFA8A878),
    dark: Color(0xFF6D6D4E),
  ),
  'Poison': TypeColors(
    light: Color(0xFFC183C1),
    normal: Color(0xFFA040A0),
    dark: Color(0xFF682A68),
  ),
  'Psychic': TypeColors(
    light: Color(0xFFFA92B2),
    normal: Color(0xFFF85888),
    dark: Color(0xFFA13959),
  ),
  'Rock': TypeColors(
    light: Color(0xFFD1C17D),
    normal: Color(0xFFB8A038),
    dark: Color(0xFF786824),
  ),
  'Steel': TypeColors(
    light: Color(0xFFD1D1E0),
    normal: Color(0xFFB8B8D0),
    dark: Color(0xFF787887),
  ),
  'Water': TypeColors(
    light: Color(0xFF9DB7F5),
    normal: Color(0xFF6890F0),
    dark: Color(0xFF445E9C),
  ),
};
