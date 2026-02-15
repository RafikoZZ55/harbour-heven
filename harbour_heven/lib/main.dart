import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:harbour_heven/data/hive/building_state.dart';
import 'package:harbour_heven/data/hive/offer_state.dart';
import 'package:harbour_heven/data/hive/player_state.dart';
import 'package:harbour_heven/data/hive/voyage_state.dart';
import 'package:harbour_heven/pages/game_main_page.dart';
import 'package:hive_flutter/adapters.dart';
void main() async {
  await Hive.initFlutter();
  WidgetsFlutterBinding.ensureInitialized();

  Hive.registerAdapter(BuildingStateAdapter());
  Hive.registerAdapter(OfferStateAdapter());
  Hive.registerAdapter(PlayerStateAdapter());
  Hive.registerAdapter(VoyageStateAdapter());

  await Hive.openBox<PlayerState>("player");

  runApp(ProviderScope(child: const Main()));
}

class Main extends ConsumerStatefulWidget {
  const Main({super.key});


  @override
  createState() => _MainState();
}

class _MainState extends ConsumerState<Main> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color.fromARGB(255, 0, 255, 76), 
          contrastLevel: 0,
          brightness: Brightness.light,
        ),
      ),

      home: GameMainPage(),
    );
  }
}