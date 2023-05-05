import 'package:flutter/material.dart';
import 'package:pokemon_list_api/home_page.dart';
import 'package:pokemon_list_api/poke_controller.dart';
import 'package:provider/provider.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => PokemonController(),
      child: const MaterialApp(
        home: HomePage(),
      ),
    );
  }
}