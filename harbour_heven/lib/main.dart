import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:harbour_heven/data/hive/building_state.dart';
import 'package:harbour_heven/data/hive/offer_state.dart';
import 'package:harbour_heven/data/hive/player_state.dart';
import 'package:harbour_heven/data/hive/voyage_state.dart';
import 'package:hive_flutter/adapters.dart';
void main() async {
  Hive.initFlutter();
  
  Hive.registerAdapter(BuildingStateAdapter());
  Hive.registerAdapter(OfferStateAdapter());
  Hive.registerAdapter(PlayerStateAdapter());
  Hive.registerAdapter(VoyageStateAdapter());

  await Hive.openBox<PlayerState>("player");

  runApp(ProviderScope(child: const Main()));
}

class Main extends StatefulWidget {
  const Main({super.key});

  @override
  createState() => _MainState();
}

class _MainState extends State<Main> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp();
  }
}