import 'package:flutter/material.dart';
import 'package:pokemon_app/pokemon.dart';

class PokemonDetails extends StatefulWidget {

  final Pokemon pokemon;
  final evolution;

  PokemonDetails({this.pokemon, this.evolution});

  @override
  _PokemonDetailsState createState() => _PokemonDetailsState();
}

class _PokemonDetailsState extends State<PokemonDetails> {

  bodyWidget(BuildContext context) => Stack(
    children: <Widget>[
      Positioned(
        height: MediaQuery.of(context).size.height / 1.5,
        width: MediaQuery.of(context).size.width - 20,
        left: 10.0,
        top: MediaQuery.of(context).size.height * 0.15,
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[

              SizedBox(
                height: 70.0,

              ),

              Text(
                widget.pokemon.name,
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text("Height: ${widget.pokemon.height}"),
              Text("Weight: ${widget.pokemon.weight}"),
              Text("Types"),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: widget.pokemon.type.map((t) => FilterChip(
                  backgroundColor: Colors.lightBlueAccent,
                  label: Text(t),
                  onSelected: (b){},
                )).toList(),
              ),
              Text("Weakness"),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: widget.pokemon.weaknesses.map((w) => FilterChip(
                  backgroundColor: Colors.indigo,
                  label: Text(w),
                  onSelected: (b){},
                )).toList(),
              ),
              Text(widget.evolution),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children:
                widget.evolution == "No Evolution" ? widget.pokemon.weaknesses.map(
                        (p) => FilterChip(
                      backgroundColor: Colors.pinkAccent,
                      label: Text(""),
                      onSelected: (b){},
                    )).toList():
                widget.evolution == "Prev Evolution" ? widget.pokemon.prevEvolution.map(
                (p) => FilterChip(
                  backgroundColor: Colors.pinkAccent,
                  label: Text(p.name),
                onSelected: (b){},
                )).toList() : widget.pokemon.nextEvolution.map(
                (n) => FilterChip(
                  backgroundColor: Colors.pinkAccent,
                  label: Text(n.name),
                onSelected: (b){},
                )).toList(),
              )
            ],
          ),
        ),
      ),
      Align(
        alignment: Alignment.topCenter,
        child: Hero(tag: widget.pokemon.img,child: Container(
          height: 200.0,
          width: 200.0,
          decoration: BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.cover,
              image: NetworkImage(widget.pokemon.img),
            )
          ),
        ),),
      ),
    ],
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.cyan,
      appBar: AppBar(
        elevation: 0.0,
        title: Text(widget.pokemon.name),
        centerTitle: true,
        backgroundColor: Colors.cyan,
      ),
      body: bodyWidget(context),
    );
  }
}