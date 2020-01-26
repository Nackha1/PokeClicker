import 'package:flutter/material.dart';
import 'package:pokeclicker/classes/pokemon.dart';
import 'package:pokeclicker/classes/typeColors.dart';
import 'package:pokeclicker/colors.dart';
import 'package:pokeclicker/pages/details.dart';

Widget buildPokemonTile(BuildContext context, Pokemon pokemon) {
  TypeColors _pokeColors = pokemonTypeColor[pokemon.type[0]];
  return Padding(
    padding: const EdgeInsets.all(4.0),
    child: Material(
      type: MaterialType.card,
      elevation: 1,
      borderRadius: BorderRadius.all(Radius.circular(16.0)),
      clipBehavior: Clip.antiAlias,
      color: _pokeColors.light,
      child: InkWell(
        splashColor: _pokeColors.normal,
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (BuildContext context) => DetailsPage(
                    pokemon: pokemon,
                  )));
        },
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Stack(
            alignment: Alignment.center,
            children: <Widget>[
              Align(
                alignment: Alignment.topRight,
                child: Text(
                  '#${pokemon.id.toString().padLeft(3, '0')}',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 28,
                    color: Colors.black38,
                  ),
                ),
              ),
              Column(
                children: <Widget>[
                  Expanded(
                    flex: 4,
                    child: Hero(
                      tag: pokemon.name,
                      child: Image.asset(
                        'assets/front/${pokemon.name.toLowerCase().replaceAll(' ', '_')}.gif',
                        alignment: Alignment.bottomCenter,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                  ),
                  Expanded(
                    flex: 1,
                    child: Text(
                      pokemon.name,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: Colors.black54,
                        //color: _pokeColors.dark,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    ),
  );
}

/* Unused implementation of widget */
// import 'package:flutter/material.dart';
// import 'package:pokeclicker/classes/pokemon.dart';
// import 'package:pokeclicker/classes/typeColors.dart';
// import 'package:pokeclicker/colors.dart';
// import 'package:pokeclicker/pages/details.dart';

// class PokemonTile extends StatefulWidget {
//   PokemonTile({Key key, this.pokemon}) : super(key: key);

//   final Pokemon pokemon;

//   @override
//   _PokemonTileState createState() => _PokemonTileState();
// }

// class _PokemonTileState extends State<PokemonTile> {
//   Pokemon pokemon;
//   TypeColors colors;

//   @override
//   void initState() {
//     super.initState();

//     pokemon = widget.pokemon;
//     colors = pokemonTypeColor[pokemon.type[0]];
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.all(4.0),
//       child: Material(
//         type: MaterialType.card,
//         elevation: 1,
//         borderRadius: BorderRadius.all(Radius.circular(10.0)),
//         clipBehavior: Clip.antiAlias,
//         color: colors.light,
//         child: InkWell(
//           splashColor: colors.normal,
//           onTap: () {
//             Navigator.of(context).push(MaterialPageRoute(
//                 builder: (BuildContext context) => Details(
//                       pokemon: pokemon,
//                     )));
//           },
//           child: Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: Stack(
//               alignment: Alignment.center,
//               children: <Widget>[
//                 Align(
//                   alignment: Alignment.topRight,
//                   child: Text(
//                     '#${pokemon.id.toString().padLeft(3, '0')}',
//                     style: TextStyle(
//                         fontWeight: FontWeight.bold,
//                         fontSize: 28,
//                         color: Colors.black26),
//                   ),
//                 ),
//                 Column(
//                   children: <Widget>[
//                     Expanded(
//                       flex: 4,
//                       child: Hero(
//                         tag: pokemon.name,
//                         child: Image.asset(
//                           'assets/front/${pokemon.name.toLowerCase().replaceAll(' ', '_')}.gif',
//                           alignment: Alignment.bottomCenter,
//                         ),
//                       ),
//                     ),
//                     Padding(
//                       padding: const EdgeInsets.all(8.0),
//                     ),
//                     Expanded(
//                       flex: 1,
//                       child: Text(
//                         pokemon.name,
//                         style: TextStyle(
//                           fontWeight: FontWeight.bold,
//                           fontSize: 22,
//                           color: Colors.black87,
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
