import 'package:flutter/material.dart';
import 'package:package_info/package_info.dart';
import 'package:pokeclicker/classes/pokeManager.dart';
import 'package:pokeclicker/classes/themeChanger.dart';
import 'package:provider/provider.dart';

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  PackageInfo _packageInfo = PackageInfo(
    appName: 'Unknown',
    packageName: 'Unknown',
    version: 'Unknown',
    buildNumber: 'Unknown',
  );

  @override
  void initState() {
    super.initState();
    _initPackageInfo();
  }

  Future<void> _initPackageInfo() async {
    final PackageInfo info = await PackageInfo.fromPlatform();
    setState(() {
      _packageInfo = info;
    });
  }

  Future<bool> _showDialog(BuildContext context) {
    return showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text("Reset Data?"),
              content:
                  Text("This will reset all your current progress and data"),
              actions: <Widget>[
                FlatButton(
                  child: Text("CANCEL"),
                  onPressed: () {
                    Navigator.of(context).pop(false);
                  },
                ),
                RaisedButton(
                  child: Text("RESET"),
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
    ThemeChanger _themeChanger = Provider.of<ThemeChanger>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
        centerTitle: true,
      ),
      body: Column(
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
          ListTile(
            title: Text('Level up your prestige'),
            subtitle: Text('Current level: ${PokeManager.prestige}'),
            trailing: RaisedButton(
                child: Text('PRESTIGE'),
                onPressed: PokeManager.completed
                    ? () {
                        Navigator.of(context).pushNamed('/win');
                      }
                    : null),
          ),
          Divider(),
          ListTile(
            title: Text('Complete Pokedex'),
            trailing: RaisedButton(
              child: Text('COMPLETE'),
              onPressed: () {
                PokeManager.completedPokedex();
                setState(() {});
              },
            ),
          ),
          Builder(
            builder: (context) {
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
            },
          ),
          Builder(
            builder: (BuildContext context) {
              return ListTile(
                title: Text('Reset data'),
                trailing: FlatButton(
                  child: Text('RESET'),
                  onPressed: () async {
                    if (await _showDialog(context)) {
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
                    }
                  },
                ),
              );
            },
          ),
          Expanded(child: Container()),
          Divider(),
          Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: Text(
                '${_packageInfo.appName} ${_packageInfo.version}+${_packageInfo.buildNumber}'),
          ),
        ],
      ),
    );
  }
}
