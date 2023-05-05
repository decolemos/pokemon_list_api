import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:pokemon_list_api/pokemon.dart';
import 'package:http/http.dart' as http;

class PokemonController extends ChangeNotifier {

  final url = Uri.parse("https://pokeapi.co/api/v2/pokemon/?offset=0&limit=1500");

  List<Pokemon> _list = [];

  List<Pokemon> get pokemons => _list;

  void getPokemon() async {

    await Future.delayed(const Duration(seconds: 2));

    final response = await http.get(url);

    final jsonBody = jsonDecode(response.body);

    _list = [];

    for(int index = 0; index < jsonBody['results'].length; index++){
      // log(jsonBody['results'][index]['name']);
      // log(jsonBody['results'][index]['url']);
      _list.add(
        Pokemon(
          name: (jsonBody['results'][index]['name']), 
          url: (jsonBody['results'][index]['url'])
        )
      );
    }
    notifyListeners();
  }
}