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
                  Scaffold.of(context).removeCurrentSnackBar();
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
                  Scaffold.of(context).removeCurrentSnackBar();
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
