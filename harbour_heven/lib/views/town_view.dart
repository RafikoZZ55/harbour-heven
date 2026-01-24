import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:harbour_heven/data/model/building/building.dart';
import 'package:harbour_heven/data/model/building/generator.dart';
import 'package:harbour_heven/data/model/building/tawern.dart';
import 'package:harbour_heven/data/model/enum/building_type.dart';
import 'package:harbour_heven/data/model/player/player.dart';
import 'package:harbour_heven/data/providers/player/player_provider.dart';

class TownView extends ConsumerStatefulWidget {
  const TownView({ super.key });

  @override
  createState() => _TownViewState();
}

class _TownViewState extends ConsumerState<TownView> {
  @override
  Widget build(BuildContext context) {
    Player player = ref.watch(playerProvider);
    Tawern tawern = player.buildings.whereType<Tawern>().first;
    List<Generator> generators = player.buildings.whereType<Generator>().toList();
    List<Building> buildings = player.buildings.where((element) {
      List<BuildingType> temp = BuildingType.buildings();
      return temp.contains(element.type);
    }).toList();


    return Container(
      child: Column(
        children: [
          Text("tawern $tawern"),
          Text("generators $generators"),
          Text("buildings $buildings"),
        ],
      ),
    );
  }
}