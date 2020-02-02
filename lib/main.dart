import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pokeclicker/classes/pokeManager.dart';
import 'package:pokeclicker/globals.dart';
import 'package:pokeclicker/pages/clicker.dart';
import 'package:pokeclicker/pages/pokedex.dart';
import 'package:pokeclicker/pages/settings.dart';
import 'package:pokeclicker/pages/shop.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await PokeManager.initialize();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle.dark.copyWith(statusBarColor: Colors.transparent));

    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

    loadPokedex(context);

    return MaterialApp(
      title: 'PokeClicker',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        brightness: Brightness.light,
        primaryColor: Colors.white,
      ),
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
