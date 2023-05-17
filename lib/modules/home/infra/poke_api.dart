import 'dart:convert';

import 'package:http/http.dart' as http;

class PokemonApi {
  final http.Client _client;

  PokemonApi(this._client);

  Future<Map<String, dynamic>?> getPokemonList() async {
    try {
      var url =
          Uri.parse("https://pokeapi.co/api/v2/pokemon/?offset=0&limit=1281");
      var response = await _client.get(url);
      var pokemonListJSON = json.decode(response.body) as Map<String, dynamic>;
      return pokemonListJSON;
    } catch (e) {
      print(e);
    }
  }

  Future<Map<String, dynamic>?> getPokemon(String name) async {
    try {
      var url = Uri.parse("https://pokeapi.co/api/v2/pokemon/$name");
      var response = await _client.get(url);
      var pokemonJson = json.decode(response.body) as Map<String, dynamic>;
      return pokemonJson;
    } catch (e) {
      print(e);
    }
  }
}
