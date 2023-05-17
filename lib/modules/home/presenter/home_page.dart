import 'package:flutter/material.dart';
import 'package:pokedex/core/components/loader.dart';
import 'package:pokedex/modules/home/domain/pokemon_controller.dart';

import '../../../core/components/pokemon_list_item.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.title});

  final String title;

  @override
  State<HomePage> createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    var pokeController = PokemonController();
    Future<List<String>> pokemonList = pokeController.getPokemonNameList();

    return Scaffold(
      body: Center(
        child: FutureBuilder<List<String>>(
            future: pokemonList,
            builder: (BuildContext context,
                AsyncSnapshot<List<String>> pokemonListSnapshot) {
              if (pokemonListSnapshot.hasData &&
                  pokemonListSnapshot.data != null) {
                return ListView.separated(
                    padding: const EdgeInsets.all(10),
                    separatorBuilder: (BuildContext context, int index) =>
                        const Divider(color: Colors.white, height: 10),
                    itemCount: pokemonListSnapshot.data!.length,
                    itemBuilder: (BuildContext context, int index) {
                      var pokeName = pokemonListSnapshot.data![index];
                      return PokemonListItem(pokeName);
                    });
              } else if (pokemonListSnapshot.hasError) {
                var message = "Awaiting result...";
                return Loader(message);
              } else {
                var message = "Loading Pokemons...";
                return Loader(message);
              }
            }),
      ),
    );
  }
}
