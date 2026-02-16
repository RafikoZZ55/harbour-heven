import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:harbour_heven/components/building_card.dart';
import 'package:harbour_heven/data/model/building/building.dart';
import 'package:harbour_heven/data/model/enum/building_type.dart';
import 'package:harbour_heven/data/model/player/player.dart';
import 'package:harbour_heven/data/providers/player/player_provider.dart';

class TownGeneratorsView extends ConsumerWidget {
const TownGeneratorsView({ super.key });

  @override
  Widget build(BuildContext context, WidgetRef ref){
    final Player player = ref.watch(playerProvider);
    final List<Building> generators = player.buildings.where((b) => BuildingType.generators().contains(b.type)).toList(); 


    return ListView(
      children: generators.map((e) => BuildingCard(buidingIndex:  player.buildings.indexOf(e))).toList(),
    );
  }
}