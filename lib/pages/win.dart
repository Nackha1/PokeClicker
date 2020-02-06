import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pokeclicker/classes/pokeManager.dart';
import 'package:pokeclicker/widgets/customShapeClipper.dart';

class WinPage extends StatefulWidget {
  @override
  _WinPageState createState() => _WinPageState();
}

class _WinPageState extends State<WinPage> {
  Future<bool> _showDialog(BuildContext context) {
    return showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text("Prestige?"),
              content: Text(
                  "Your data will be resetted but you will receive benefits in the next runs"),
              actions: <Widget>[
                FlatButton(
                  child: Text("CANCEL"),
                  onPressed: () {
                    Navigator.of(context).pop(false);
                  },
                ),
                RaisedButton(
                  child: Text("PRESTIGE"),
                  onPressed: () {
                    Navigator.of(context).pop(true);
                  },
                ),
              ],
            );
          },
        ) ??
        false;
  }

  @override
  Widget build(BuildContext context) {
    // print(Colors.green.computeLuminance() < 0.5);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        //brightness: Brightness.dark,
        title: Text(
          'Congratulations',
          //style: TextStyle(color: Colors.white70),
        ),
        centerTitle: true,
        elevation: 0.0,
        //iconTheme: IconThemeData(color: Colors.white70),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            flex: 5,
            child: Stack(
              alignment: Alignment.topCenter,
              children: <Widget>[
                ClipPath(
                  clipper: CustomShapeClipper(),
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Colors.green, Colors.green[900]],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                    ),
                  ),
                ),
                Center(
                  child: Image.asset(
                    'assets/win.png',
                    fit: BoxFit.contain,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 5,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Text(
                  'You have successfully catched every Pokemon in the Pokedex',
                  style: Theme.of(context).textTheme.title,
                  textAlign: TextAlign.center,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: <Widget>[
                      Text(
                        'PRESTIGE LEVEL',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        '${PokeManager.prestige}',
                        style: Theme.of(context).textTheme.display1,
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Container(),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: Colors.green,
        onPressed: () async {
          if (await _showDialog(context)) {
            PokeManager.lvlUpPrestige();
            Navigator.of(context).popUntil(ModalRoute.withName('/'));
          }
        },
        icon: Icon(FontAwesomeIcons.angleDoubleUp),
        label: Text('PRESTIGE'),
      ),
    );
  }
}
