import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pokeclicker/classes/pokeManager.dart';
import 'package:pokeclicker/classes/theme.dart';
import 'package:pokeclicker/globals.dart';
import 'package:pokeclicker/pages/clicker.dart';
import 'package:pokeclicker/pages/pokedex.dart';
import 'package:pokeclicker/pages/settings.dart';
import 'package:pokeclicker/pages/shop.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await PokeManager.initialize();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: Colors.transparent));

    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

    loadPokedex(context);

    return ChangeNotifierProvider<ThemeChanger>(
      create: (context) {
        return ThemeChanger(
          PokeManager.readTheme()
              ? ThemeData.dark()
              : ThemeData(
                  primaryColor: Colors.white,
                ),
        );
      },
      child: MaterialAppWithTheme(),
    );
  }
}

class MaterialAppWithTheme extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<ThemeChanger>(context);
    return MaterialApp(
      title: 'PokeClicker',
      theme: theme.getTheme(),
      initialRoute: '/',
      routes: {
        '/': (context) => ClickerPage(),
        '/pokedex': (context) => PokedexPage(),
        '/shop': (context) => ShopPage(),
        '/settings': (context) => SettingsPage(),
      },
      debugShowCheckedModeBanner: false,
    );
  }
}
