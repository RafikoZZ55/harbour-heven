import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:harbour_heven/data/model/building/voyage_port.dart';
import 'package:harbour_heven/data/model/voyage/voyage.dart';
import 'package:harbour_heven/data/providers/player/player_provider.dart';

class VoyageCard extends ConsumerStatefulWidget {
  const VoyageCard({ super.key, required this.index });
  final int index;

  @override
  createState() => _VoyageCardState();
}

class _VoyageCardState extends ConsumerState<VoyageCard> {
  @override
  Widget build(BuildContext context) {
    Voyage voyage = ref.watch(playerProvider.select(
      (p) => p.buildings.whereType<VoyagePort>().first.currentVoyages[widget.index]
    ));

    return Card(
      
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
            children: [
              Text(voyage.difficulty.name),
              Text(voyage.type.name),
              Text(voyage.recources.toString()),
              Text(voyage.successThreshold.toString())
            ],
        ),
      ),
    );
  }
}