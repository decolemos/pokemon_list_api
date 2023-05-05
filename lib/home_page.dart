import 'package:flutter/material.dart';
import 'package:pokemon_list_api/poke_controller.dart';
import 'package:pokemon_list_api/pokemon_detail.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  void initState() {
    super.initState();
    Provider.of<PokemonController>(context, listen: false).getPokemon();
  }

  @override
  Widget build(BuildContext context) {

    final provider = Provider.of<PokemonController>(context);
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lista Pokemon'),
        centerTitle: true,
      ),

      body: provider.pokemons.isEmpty ? const Center(
        child: CircularProgressIndicator(),
      )
      : 
      ListView.builder(
        itemCount: 1077,
        itemBuilder: (context, index) => Card(
          child: ListTile(
            onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => PokemonDetail(pokemon: provider.pokemons[index],),)),
            leading: Image.network('https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/${index+1}.png'),
            title: Text(
              provider.pokemons[index].name,
            ),
            subtitle: Text(
              provider.pokemons[index].url
            ),
          ),
        ),
      ),
    );
  }
}

