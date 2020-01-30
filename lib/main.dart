import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:pokemon_app/pokemon.dart';
import 'package:pokemon_app/pokemon_detail.dart';

void main() => runApp(MaterialApp(
  title: "Pokemon App",
  home: HomePage(),
  debugShowCheckedModeBanner: false,
));

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  var url = "https://raw.githubusercontent.com/Biuni/PokemonGO-Pokedex/master/pokedex.json";
  PokeHub pokeHub;

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  fetchData() async{
    var response = await http.get(url);
    print(response.body);

    var decodedJson = jsonDecode(response.body);
    pokeHub = PokeHub.fromJson(decodedJson);
    setState(() {
      
    });
  }

  String evolutionSet(poke) {
    if (poke.nextEvolution == null && poke.prevEvolution == null) {
      return "No Evolution";
    }
    else if (poke.nextEvolution == null) {
      return "Prev Evolution";
    }
    return "Next Evolution";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Pokemon App"),
        backgroundColor: Colors.cyan,
        centerTitle: true, 
      ),
      body: pokeHub == null ? Center(child: CircularProgressIndicator(),) :
      GridView.count(
        crossAxisCount: 2,
        children: pokeHub.pokemon.map((poke) => Padding(
          padding: const EdgeInsets.all(2.0),
          child: InkWell(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(
                builder: (context) => PokemonDetails(
                  evolution: evolutionSet(poke),
                  pokemon: poke,
                )));
            },
            child: Hero(
              tag: poke.img,
              child: Card(
                elevation: 3.0,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Container(
                      height: 100.0,
                      width: 100.0,
                      decoration: BoxDecoration(
                        image: DecorationImage(image: NetworkImage(poke.img))
                      ),
                    ),
                    Text(poke.name, style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),)
                  ],
                ),
              ),
            ),
          ),
        )).toList(),
      ),
      drawer: Drawer(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          fetchData();
        },
        child: Icon(Icons.refresh),
      ),
    );

  }
}