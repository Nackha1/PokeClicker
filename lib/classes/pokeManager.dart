import 'package:shared_preferences/shared_preferences.dart';

class PokeManager {
  static SharedPreferences prefs;
  static int coins;
  static int multiplier;
  static List<int> caughtPokemons;
  static int savedCoins;
  static int savedMultiplier;
  static List<int> savedCaughtPokemons;

  PokeManager();

  static Future<void> initialize() async {
    prefs = await SharedPreferences.getInstance();
    coins = prefs.getInt('coins') ?? 0;
    multiplier = prefs.getInt('multiplier') ?? 1;
    caughtPokemons = List<int>();
    _readCaughtPokemons();
  }

  static void _readCaughtPokemons() {
    List<String> aux = prefs.getStringList('caughtPokemons') ?? List<String>();
    aux.forEach((item) {
      caughtPokemons.add(int.parse(item));
    });
  }

  static void _writeCaughtPokemons() async {
    List<String> aux = List<String>();
    caughtPokemons.forEach((item) {
      aux.add(item.toString());
    });
    await prefs.setStringList('caughtPokemons', aux);
  }

  static void setCoins(int amount) async {
    coins = amount;
    await prefs.setInt('coins', coins);
  }

  static void setMultiplier(int amount) async {
    multiplier = amount;
    await prefs.setInt('multiplier', multiplier);
  }

  static void incrementCoinsByMultiplier() async {
    coins += multiplier;
    await prefs.setInt('coins', coins);
  }

  static void addPokemon(int pokemon) async {
    caughtPokemons.add(pokemon);
    _writeCaughtPokemons();
  }

  static void saveValues() {
    savedCoins = coins;
    savedMultiplier = multiplier;
    savedCaughtPokemons = caughtPokemons;
  }

  static void restoreValues() async {
    coins = savedCoins;
    await prefs.setInt('coins', coins);
    multiplier = savedMultiplier;
    await prefs.setInt('multiplier', multiplier);
    caughtPokemons = savedCaughtPokemons;
    _writeCaughtPokemons();
  }

  static void resetValues() async {
    coins = 0;
    await prefs.setInt('coins', coins);
    multiplier = 1;
    await prefs.setInt('multiplier', multiplier);
    caughtPokemons = List();
    _writeCaughtPokemons();
  }
}
