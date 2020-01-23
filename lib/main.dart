import 'dart:convert';

import 'package:draggable_scrollbar/draggable_scrollbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pokeclicker/classes/pokemon.dart';
import 'package:pokeclicker/widgets/pokemonTile.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle.dark.copyWith(statusBarColor: Colors.transparent));

    return MaterialApp(
      title: 'PokeClicker',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        brightness: Brightness.light,
        primaryColor: Colors.white,
      ),
      home: MyHomePage(title: 'Pokedex'),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Pokemon> pokedex;
  bool _isSortedAlpha;
  ScrollController myScrollController;

  @override
  void initState() {
    super.initState();

    pokedex = List<Pokemon>();
    _isSortedAlpha = false;
    myScrollController = ScrollController();

    fetchData();
  }

  @override
  void didChangeDependencies() {
    pokedex.forEach((item) {
      precacheImage(
          AssetImage(
              'assets/front/${item.name.toLowerCase().replaceAll(' ', '_')}.gif'),
          context);
    });

    super.didChangeDependencies();
  }

  fetchData() async {
    String encodedData =
        await DefaultAssetBundle.of(context).loadString("assets/pokedex.json");
    List<dynamic> decodedJson = jsonDecode(encodedData);

    decodedJson.forEach((item) {
      Pokemon pokemon = Pokemon.fromJson(item);
      setState(() {
        pokedex.add(pokemon);
      });
    });
  }

  void _sort() {
    _isSortedAlpha
        ? pokedex.sort((a, b) => a.id.compareTo(b.id))
        : pokedex.sort((a, b) => a.name.compareTo(b.name));
    setState(() {
      _isSortedAlpha = !_isSortedAlpha;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.title,
          style: Theme.of(context).textTheme.title,
        ),
        centerTitle: true,
      ),
      body: pokedex.isEmpty
          ? Center(
              child: CircularProgressIndicator(),
            )
          : DraggableScrollbar.rrect(
              // labelTextBuilder: (offset) {
              //   final int currentItem = myScrollController.hasClients
              //       ? (myScrollController.offset /
              //               myScrollController.position.maxScrollExtent *
              //               pokedex.length)
              //           .floor()
              //       : 0;
              //   return Text("$currentItem");
              // },
              controller: myScrollController,
              child: GridView.builder(
                controller: myScrollController,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2),
                itemCount: pokedex.length,
                itemBuilder: (BuildContext context, int index) {
                  return buildPokemonTile(context, pokedex[index]);
                },
              ),
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: _sort,
        tooltip: 'Increment',
        child: Icon(_isSortedAlpha ? Icons.sort : Icons.sort_by_alpha),
      ),
    );
  }
}
