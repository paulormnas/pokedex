class Catalog {
  late final Map<String, dynamic>? _pokemonListJSON;
  List<String> _namesList = [];

  get namesList {
    _namesList = [];
    try {
      for (Map<String, dynamic> pokemon in _pokemonListJSON?["results"]) {
        _namesList.add(pokemon['name']);
      }
      return _namesList;
    } catch (e) {
      print(e);
      return _namesList;
    }
  }

  Catalog(this._pokemonListJSON);
}

class Pokemon {
  String name = "";
  List<String> abilities = [];
  String species = "";
  int weight = 0;
  String photo = "";
}
