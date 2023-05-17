import 'package:http/http.dart';
import 'package:pokedex/modules/home/domain/pokemon.dart';

import '../infra/poke_api.dart';

class PokemonController {
  Client client = Client();
  late PokemonApi pokeApi;
  late Catalog catalog;

  PokemonController() {
    pokeApi = PokemonApi(client);
    // Map<String, dynamic>? pokemonListJSON = {};
    // pokeApi.getPokemonList().then((value) {
    //   pokemonListJSON = value;
    //   if (pokemonListJSON != null) {
    //     catalog = Catalog(pokemonListJSON);
    //   }
    // });
  }

  Future<List<String>> getPokemonNameList() async {
    var pokemonListJSON = await pokeApi.getPokemonList();
    catalog = Catalog(pokemonListJSON);
    return catalog.namesList;
  }

  Future<Pokemon> getPokemon(String name) async {
    var pokemonJSON = await pokeApi.getPokemon(name);
    var pokemon = Pokemon();
    if (pokemonJSON != null) {
      pokemon.name = pokemonJSON["name"];
      pokemon.weight = pokemonJSON["weight"];
      pokemon.photo = pokemonJSON["sprites"]["front_default"];
      pokemon.species = pokemonJSON["species"]["name"];
      pokemonJSON["abilities"]
          .forEach((item) => pokemon.abilities.add(item["ability"]["name"]));
    }
    return pokemon;
  }
}
