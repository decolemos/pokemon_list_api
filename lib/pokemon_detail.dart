import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:pokemon_list_api/pokemon.dart';

class PokemonDetail extends StatefulWidget {
  const PokemonDetail({super.key, required this.pokemon});

  final Pokemon pokemon;

  @override
  State<PokemonDetail> createState() => _PokemonDetailState();
}

class _PokemonDetailState extends State<PokemonDetail> {

  bool isLoading = false;

  late dynamic pokemon;

  @override
  void initState() {
    super.initState();
    getDetail();
  }

  toggleLoading() => setState(() => isLoading = !isLoading);

  getDetail() async {
    toggleLoading();
    
    try{

      final response = await http.get(Uri.parse(widget.pokemon.url));

      final jsonBody = jsonDecode(response.body);

      pokemon = jsonBody;

      log(jsonBody['sprites']['front_default']);

    } catch(exception) {
      log(exception.toString());
    }

    toggleLoading();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pokemon Detail'),
        centerTitle: true,
      ),
      body: isLoading ? const Center(
        child: CircularProgressIndicator() 
      )
      : ListView(
        children: [
          Container(
            color: Colors.grey,
            height: 100,
            width: double.infinity,
            child: Image.network(pokemon['sprites']['front_default'])
          ),
          Center(
            child: Text(widget.pokemon.name, style: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold),),
          ),
          const SizedBox(
            height: 20,
          ),
          for(int index = 0; pokemon['types'].length > index; index++) 
          Center(
            child: Text('Tipo ${index+1} : ${pokemon['types'][index]['type']['name']}')
          ),
          const SizedBox(
            height: 20,
          ),
          for(int index = 0; pokemon['abilities'].length > index; index++)
          Center(
            child: Text('Habilidade ${index+1} : ${pokemon['abilities'][index]['ability']['name']}'),
          ),
          const SizedBox(
            height: 20,
          ),
          for(int index = 0; pokemon['moves'].length > index; index++)
          Center(
            child: Text('Ataque ${index+1} : ${pokemon['moves'][index]['move']['name']}'),
          )
        ],
      )
    );
  }
}