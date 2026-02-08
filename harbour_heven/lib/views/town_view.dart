import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:harbour_heven/data/model/building/building.dart';
import 'package:harbour_heven/data/model/building/generator.dart';
import 'package:harbour_heven/data/model/enum/building_type.dart';
import 'package:harbour_heven/data/model/player/player.dart';
import 'package:harbour_heven/data/providers/player/player_provider.dart';
import 'package:harbour_heven/components/building_card.dart';

class TownView extends ConsumerStatefulWidget {
  const TownView({super.key});

  @override
  ConsumerState<TownView> createState() => _TownViewState();
}

class _TownViewState extends ConsumerState<TownView> {
  @override
  Widget build(BuildContext context) {
    final Player player = ref.watch(playerProvider);
    final playerController = ref.read(playerProvider.notifier);

    final List<Generator> generators =
        player.buildings.whereType<Generator>().toList();

    final List<Building> special = player.buildings.where((element) {
      return BuildingType.special().contains(element.type);
    }).toList();

    return Padding(
      padding: const EdgeInsets.all(20),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ElevatedButton(
              onPressed: () => playerController.reset(), 
              child: Text("reset")
            ),
            ElevatedButton(
              onPressed: () => playerController.addTestResources(), 
              child: Text("test")
            ),

            const Text(
              'Special',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),

            ...special.map(
              (b) => BuildingCard(
                buidingIndex: player.buildings.indexOf(b),
              ),
            ),

            const SizedBox(height: 24),

            const Text(
              'Generators',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),

            ...generators.map(
              (g) => BuildingCard(
                buidingIndex: player.buildings.indexOf(g),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
