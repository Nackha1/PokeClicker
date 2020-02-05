import 'package:flutter/material.dart';
import 'package:pokeclicker/classes/pokeManager.dart';
import 'package:pokeclicker/classes/themeChanger.dart';
import 'package:provider/provider.dart';

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    ThemeChanger _themeChanger = Provider.of<ThemeChanger>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
        centerTitle: true,
      ),
      body: ListView(
        children: <Widget>[
          ListTile(
            title: Text('Dark Theme'),
            trailing: Switch(
              value: PokeManager.readTheme(),
              onChanged: (value) {
                if (value) {
                  _themeChanger.setTheme(ThemeData.dark());
                } else {
                  _themeChanger.setTheme(ThemeData(primaryColor: Colors.white));
                }
                PokeManager.writeTheme(value);
              },
            ),
          ),
          //StepTile(),
          Divider(),
          Builder(builder: (context) {
            return ListTile(
              title: Text('Get lots of PokeCoins'),
              trailing: RaisedButton(
                child: Text('POKECOINS'),
                onPressed: () {
                  PokeManager.addCoins(777);
                  SnackBar snackBar = SnackBar(
                    content: Text('Added 777 PokeCoins to your balance'),
                    action: SnackBarAction(
                      label: 'OK',
                      onPressed: () {},
                    ),
                  );
                  Scaffold.of(context).showSnackBar(snackBar);
                },
              ),
            );
          }),
          Builder(builder: (BuildContext context) {
            return ListTile(
              title: Text('Reset data'),
              trailing: FlatButton(
                child: Text('RESET'),
                onPressed: () {
                  PokeManager.saveValues();
                  PokeManager.resetValues();
                  SnackBar snackBar = SnackBar(
                    content: Text('Data resetted successfully'),
                    action: SnackBarAction(
                      label: 'UNDO',
                      onPressed: () {
                        PokeManager.restoreValues();
                      },
                    ),
                  );
                  Scaffold.of(context).showSnackBar(snackBar);
                },
              ),
            );
          }),
        ],
      ),
    );
  }
}

// class StepTile extends StatefulWidget {
//   const StepTile({
//     Key key,
//   }) : super(key: key);

//   @override
//   _StepTileState createState() => _StepTileState();
// }

// class _StepTileState extends State<StepTile> {
//   @override
//   Widget build(BuildContext context) {
//     return ListTile(
//       title: Text('Steps counter'),
//       subtitle: Text('10 steps = 1 PokeCoin'),
//       trailing: Switch(
//         value: StepManager.isListening,
//         onChanged: (value) {
//           if (value) {
//             StepManager.startListening();
//           } else {
//             StepManager.stopListening();
//           }
//           setState(() {});
//         },
//       ),
//     );
//   }
// }
