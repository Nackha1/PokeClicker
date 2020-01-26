import 'package:shared_preferences/shared_preferences.dart';

class CoinsManager {
  static SharedPreferences prefs;
  static int coins;
  static int multiplier;
  static int savedCoins;
  static int savedMultiplier;

  CoinsManager();

  static Future<void> initialize() async {
    prefs = await SharedPreferences.getInstance();
    coins = prefs.getInt('coins') ?? 0;
    multiplier = prefs.getInt('multiplier') ?? 1;
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

  static void saveValues() {
    savedCoins = coins;
    savedMultiplier = multiplier;
  }

  static void restoreValues() async {
    coins = savedCoins;
    await prefs.setInt('coins', coins);
    multiplier = savedMultiplier;
    await prefs.setInt('multiplier', multiplier);
  }

  static void resetValues() async {
    coins = 0;
    await prefs.setInt('coins', coins);
    multiplier = 1;
    await prefs.setInt('multiplier', multiplier);
  }
}
