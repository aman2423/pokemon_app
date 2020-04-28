import 'package:flutter/material.dart';

import 'pokemon_database.dart';

class PokeDetail extends StatelessWidget {
  final Pokemon pokemon;

  PokeDetail({this.pokemon});

  bodyWidget(BuildContext context) => Stack(
        children: <Widget>[
          Positioned(
            height: MediaQuery.of(context).size.height / 1.8,
            width: MediaQuery.of(context).size.width - 20,
            left: 10,
            top: MediaQuery.of(context).size.height * .217,
            child: Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25.0)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  SizedBox(
                    height: 18.0,
                  ),
                  Text(
                    pokemon.name,
                    style: TextStyle(
                      fontSize: 25,
                      color: Color(0xFF2E0B39),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'Height : ${pokemon.height}',
                    textScaleFactor: 1.35,
                  ),
                  Text(
                    'Weight : ${pokemon.weight}',
                    textScaleFactor: 1.35,
                  ),
                  Text(
                    'Types : ',
                    textScaleFactor: 1.35,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: pokemon.type
                        .map((t) => FilterChip(
                              label: Text(
                                t,
                                textScaleFactor: 1.35,
                              ),
                              onSelected: (b) {},
                              backgroundColor: Color(0xFFFFC300),
                            ))
                        .toList(),
                  ),
                  Text(
                    'Weakness : ',
                    textScaleFactor: 1.35,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: pokemon.weaknesses
                        .map((t) => FilterChip(
                              label: Text(
                                t,
                                textScaleFactor: 1.1,
                                style: TextStyle(color: Colors.white),
                              ),
                              onSelected: (b) {},
                              backgroundColor: Color(0xFFFF0000),
                            ))
                        .toList(),
                  )
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.topCenter,
            child: Hero(
              tag: pokemon.img,
              child: Container(
                height: 200.0,
                width: 200.0,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(pokemon.img),fit: BoxFit.cover
                  ),

                ),
              ),
            ),
          )
        ],
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF84499E),
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        backgroundColor: Color(0xFF84499E),
        title: Text(
          pokemon.name,
          textScaleFactor: 1.2,
        ),
      ),
      body: bodyWidget(context),
    );
  }
}
