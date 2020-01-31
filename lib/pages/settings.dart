import 'package:flutter/material.dart';
import 'package:pokeclicker/classes/coinsManager.dart';

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
        centerTitle: true,
      ),
      body: ListView(
        children: <Widget>[
          ResetData(),
        ],
      ),
    );
  }
}

class ResetData extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text('Reset data'),
      trailing: FlatButton(
        child: Text('RESET'),
        onPressed: () async {
          CoinsManager.saveValues();
          CoinsManager.resetValues();
          SnackBar snackBar = SnackBar(
            content: Text('Data resetted successfully'),
            duration: Duration(seconds: 3),
            action: SnackBarAction(
              label: 'UNDO',
              onPressed: () async {
                CoinsManager.restoreValues();
              },
            ),
          );
          Scaffold.of(context).showSnackBar(snackBar);
        },
      ),
    );
  }
}
