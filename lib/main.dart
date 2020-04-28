import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:poke_app/poke_detail.dart';
import 'package:poke_app/pokemon_database.dart';
import 'dart:convert';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Pokemon App',
      theme: ThemeData(accentColor: Color(0xFFFFC300)),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var url =
      'https://raw.githubusercontent.com/Biuni/PokemonGO-Pokedex/master/pokedex.json';

  PokeHub pokeHub;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchData();
  }

  fetchData() async {
    var res = await http.get(url);
    var decodedValue = jsonDecode(res.body);
    pokeHub = PokeHub.fromJson(decodedValue);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        backgroundColor: Color(0xFF84499E),
        title: Text('Pokemon'),
      ),
      body: pokeHub == null
          ? Center(
              child: CircularProgressIndicator(
                strokeWidth: 2.5,
              ),
            )
          : GridView.count(
              crossAxisCount: 2,
              children: pokeHub.pokemon.map((Pokemon poke) {
                return Padding(
                  padding: EdgeInsets.symmetric(vertical: 7.0, horizontal: 5.0),
                  child: InkWell(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return PokeDetail(pokemon: poke);
                      }));
                    },
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      elevation: 3.0,
                      child: Column(
                        children: <Widget>[
                          Hero(
                            tag: poke.img,
                            child: Container(
                              height: MediaQuery.of(context).size.height * 0.22,
                              width: MediaQuery.of(context).size.width * 0.3,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: NetworkImage(poke.img),
                                ),
                              ),
                            ),
                          ),
                          Text(
                            poke.name,
                            textScaleFactor: 1.5,
                            style: TextStyle(
                                color: Color(0xFF2E0B39),
                                fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
    );
  }
}
