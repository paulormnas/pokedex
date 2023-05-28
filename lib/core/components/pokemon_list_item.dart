import 'package:flutter/material.dart';

import '../../modules/home/domain/pokemon.dart';
import '../../modules/home/domain/pokemon_controller.dart';
import 'loader.dart';

// ignore: must_be_immutable
class PokemonListItem extends StatelessWidget {
  late String pokeName;

  PokemonListItem(this.pokeName, {super.key}) {}

  @override
  Widget build(BuildContext context) {
    var pokeController = PokemonController();
    Future<Pokemon> pokemon = pokeController.getPokemon(pokeName);

    return FutureBuilder<Pokemon>(
        future: pokemon,
        builder:
            (BuildContext context, AsyncSnapshot<Pokemon> pokemonSnapshot) {
          if (pokemonSnapshot.hasData && pokemonSnapshot.data != null) {
            return Container(
              // width: MediaQuery.of(context).size.width - 40,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  border: Border.all(color: Colors.indigo)),
              child: Row(children: [
                Image(
                    image:
                        NetworkImage(pokemonSnapshot.data!.photo, scale: 0.8)),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(pokemonSnapshot.data!.name,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: Colors.indigoAccent)),
                    Text("Species: ${pokemonSnapshot.data!.species}"),
                    Text("Weight: ${pokemonSnapshot.data!.weight}"),
                  ],
                )
              ]),
            );
          } else {
            var message = "Loading Pokemon...";
            return Loader(message);
          }
        });
  }
}
