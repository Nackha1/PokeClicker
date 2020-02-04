import 'package:shared_preferences/shared_preferences.dart';

class PokeManager {
  static SharedPreferences prefs;
  static int coins;
  static List<int> caughtPokemons;
  static int _savedCoins;
  static List<int> _savedCaughtPokemons;

  PokeManager();

  static Future<void> initialize() async {
    prefs = await SharedPreferences.getInstance();
    caughtPokemons = List<int>();
    _readCoins();
    _readCaughtPokemons();
  }

  static void _readCoins() {
    coins = prefs.getInt('coins') ?? 0;
  }

  static void _writeCoins() async {
    await prefs.setInt('coins', coins);
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

  static void addPokemon(int pokemon) {
    caughtPokemons.add(pokemon);
    _writeCaughtPokemons();
  }

  static void saveValues() {
    _savedCoins = coins;
    _savedCaughtPokemons = caughtPokemons;
  }

  static void restoreValues() async {
    coins = _savedCoins;
    caughtPokemons = _savedCaughtPokemons;
    _writeCoins();
    _writeCaughtPokemons();
  }

  static void resetValues() async {
    coins = 0;
    caughtPokemons = List<int>();
    _writeCoins();
    _writeCaughtPokemons();
  }
}
