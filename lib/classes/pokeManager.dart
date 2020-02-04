import 'package:shared_preferences/shared_preferences.dart';

class PokeManager {
  static SharedPreferences prefs;
  static int coins;
  static int progress;
  static List<int> caughtPokemons;
  static int _savedCoins;
  static int _savedProgress;
  static List<int> _savedCaughtPokemons;

  PokeManager();

  static Future<void> initialize() async {
    prefs = await SharedPreferences.getInstance();
    caughtPokemons = List<int>();
    _readCoins();
    _readProgress();
    _readCaughtPokemons();
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
    progress += 10;
    if (progress >= 100) {
      addCoins(1);
      progress = 0;
    }
    _writeProgress();
  }

  static void addPokemon(int pokemon) {
    caughtPokemons.add(pokemon);
    _writeCaughtPokemons();
  }

  static void saveValues() {
    _savedCoins = coins;
    _savedProgress = progress;
    _savedCaughtPokemons = caughtPokemons;
  }

  static void restoreValues() async {
    coins = _savedCoins;
    progress = _savedProgress;
    caughtPokemons = _savedCaughtPokemons;

    _writeCoins();
    _writeProgress();
    _writeCaughtPokemons();
  }

  static void resetValues() async {
    coins = 0;
    progress = 0;
    caughtPokemons = List<int>();
    _writeCoins();
    _writeProgress();
    _writeCaughtPokemons();
  }
}
