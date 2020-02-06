import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pokeclicker/widgets/customShapeClipper.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutMePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Developed by'),
        centerTitle: true,
        elevation: 0.0,
        backgroundColor: Colors.lightBlue,
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: Stack(
              children: <Widget>[
                ClipPath(
                  clipper: CustomShapeClipper(),
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Colors.lightBlue, Color(0xFF2639F7)],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                    ),
                  ),
                ),
                Center(
                  child: Image.asset(
                    'assets/icon/nackha1.png',
                    fit: BoxFit.contain,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 2,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: <Widget>[
                  Center(
                    child: Text(
                      'Nazareno "Nackha1" Piccin',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('ITST J.F.Kennedy 2019/2020 5CIA'),
                  ),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        Text(
                          'App Icon by Freepik at www.flaticon.com\n',
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.caption,
                        ),
                        Text(
                          'HD animated sprites by TilableToast\n',
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.caption,
                        ),
                        Text(
                          'Default animated sprites by www.pkparaiso.com\n',
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.caption,
                        ),
                        Text(
                          'Pokémon And All Respective Names are Trademark of Nintendo 1996-2020',
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.subtitle,
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 32.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        AboutMeTile(
                          text: 'GITHUB',
                          icon: Icon(FontAwesomeIcons.github),
                          url: 'https://github.com/Nackha1',
                        ),
                        AboutMeTile(
                          text: 'INSTAGRAM',
                          icon: Icon(FontAwesomeIcons.instagram),
                          url: 'https://www.instagram.com/nackha1/',
                        ),
                        AboutMeTile(
                          text: 'EMAIL',
                          icon: Icon(FontAwesomeIcons.solidEnvelope),
                          url: 'mailto:<nackha@gmail.com>',
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

class AboutMeTile extends StatelessWidget {
  AboutMeTile({this.text, this.icon, this.url});

  final String text;
  final Icon icon;
  final String url;

  @override
  Widget build(BuildContext context) {
    _launchURL() async {
      if (await canLaunch(url)) {
        await launch(url);
      } else {
        throw 'Could not launch $url';
      }
    }

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Text(
          text,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        IconButton(
          icon: icon,
          onPressed: _launchURL,
        ),
      ],
    );
  }
}
