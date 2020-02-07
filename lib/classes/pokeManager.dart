import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:pokeclicker/classes/pokeball.dart';
import 'package:pokeclicker/classes/pokemon.dart';
import 'package:pokeclicker/classes/typeColors.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PokeManager {
  static SharedPreferences prefs;
  static int coins;
  static int progress;
  static int prestige;
  static bool completed;
  static List<int> caughtPokemons;
  static int _savedCoins;
  static int _savedProgress;
  static int _savedPrestige;
  static bool _savedCompleted;
  static List<int> _savedCaughtPokemons;

  static List<Pokemon> pokedex = List<Pokemon>();

  static final List<Pokeball> pokeballs = [
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
      cost: 25,
    ),
    Pokeball(
      name: 'Ultraball',
      colors: [Colors.amber, Colors.amber[900]],
      asset: 'assets/shop/ultraball.png',
      pokemons: 5,
      cost: 40,
    ),
    Pokeball(
      name: 'Masterball',
      colors: [Colors.deepPurple, Colors.deepPurple[900]],
      asset: 'assets/shop/masterball.png',
      pokemons: 10,
      cost: 75,
    ),
  ];

  static final Map<String, TypeColors> pokemonTypeColor = {
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

  PokeManager();

  static Future<void> initialize() async {
    prefs = await SharedPreferences.getInstance();
    caughtPokemons = List<int>();
    _readCoins();
    _readProgress();
    _readPrestige();
    _readCompleted();
    _readCaughtPokemons();
  }

  static Future<void> loadPokedex(BuildContext context) async {
    String encodedData =
        await DefaultAssetBundle.of(context).loadString("assets/pokedex.json");
    List<dynamic> decodedJson = jsonDecode(encodedData);

    PokeManager.pokedex.clear();

    decodedJson.forEach((item) {
      Pokemon pokemon = Pokemon.fromJson(item);
      PokeManager.pokedex.add(pokemon);
    });
  }

  static bool readTheme() {
    return prefs.getBool('isDark') ?? false;
  }

  static void writeTheme(bool isDark) async {
    await prefs.setBool('isDark', isDark);
  }

  static void _readCoins() {
    coins = prefs.getInt('coins') ?? 0;
  }

  static void _writeCoins() async {
    await prefs.setInt('coins', coins);
  }

  static void _readProgress() {
    progress = prefs.getInt('progress') ?? 0;
  }

  static void _writeProgress() async {
    await prefs.setInt('progress', progress);
  }

  static void _readCaughtPokemons() {
    List<String> aux = prefs.getStringList('caughtPokemons') ?? List<String>();
    aux.forEach((item) {
      caughtPokemons.add(int.parse(item));
    });
  }

  static void _readPrestige() {
    prestige = prefs.getInt('prestige') ?? 0;
  }

  static void _writePrestige() async {
    await prefs.setInt('prestige', prestige);
  }

  static void _readCompleted() {
    completed = prefs.getBool('completed') ?? false;
  }

  static void _writeCompleted() async {
    await prefs.setBool('completed', completed);
  }

  static void _writeCaughtPokemons() async {
    List<String> aux = List<String>();
    caughtPokemons.forEach((item) {
      aux.add(item.toString());
    });
    await prefs.setStringList('caughtPokemons', aux);
  }

  static bool spendCoins(int amount) {
    if (amount > coins) {
      return false;
    } else {
      coins -= amount;
      _writeCoins();
      return true;
    }
  }

  static void addCoins(int amount) {
    coins += amount;
    _writeCoins();
  }

  static void incrementProgress() {
    int power = 10 + (prestige * 5) + (caughtPokemons.length / 10).floor();
    progress += power;
    if (progress >= 100) {
      addCoins(1);
      progress %= 100;
    }
    _writeProgress();
  }

  static void addPokemon(int index) {
    caughtPokemons.add(index);
    _writeCaughtPokemons();
  }

  static void saveValues() {
    _savedCoins = coins;
    _savedProgress = progress;
    _savedPrestige = prestige;
    _savedCompleted = completed;
    _savedCaughtPokemons = caughtPokemons;
  }

  static void restoreValues() {
    coins = _savedCoins;
    progress = _savedProgress;
    prestige = _savedPrestige;
    completed = _savedCompleted;
    caughtPokemons = _savedCaughtPokemons;

    _writeCoins();
    _writeProgress();
    _writePrestige();
    _writeCompleted();
    _writeCaughtPokemons();
  }

  static void resetValues() {
    coins = 0;
    progress = 0;
    prestige = 0;
    completed = false;
    caughtPokemons = List<int>();
    _writeCoins();
    _writeProgress();
    _writePrestige();
    _writeCompleted();
    _writeCaughtPokemons();
  }

  static void completedPokedex() {
    completed = true;
    _writeCompleted();
  }

  static void lvlUpPrestige() {
    _savedPrestige = prestige;
    resetValues();
    prestige = ++_savedPrestige;
    _writePrestige();
  }

  static int getPower() =>
      10 + (prestige * 5) + (caughtPokemons.length / 10).floor();

  static int getRawPower() => 10 + (caughtPokemons.length / 10).floor();
}
