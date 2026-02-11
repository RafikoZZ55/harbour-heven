import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:harbour_heven/components/voyage_card.dart';
import 'package:harbour_heven/data/model/building/voyage_port.dart';
import 'package:harbour_heven/data/model/voyage/voyage.dart';
import 'package:harbour_heven/data/providers/player/player_provider.dart';

class VoyageView extends ConsumerStatefulWidget {
  const VoyageView({ super.key });

  @override
  createState() => _VoyageViewState();
}

class _VoyageViewState extends ConsumerState<VoyageView> {
  @override
  Widget build(BuildContext context) {
    List<Voyage> voyages = ref.watch(playerProvider.select(
      (e) => e.buildings.whereType<VoyagePort>().first.currentVoyages
    ));

    return Column(
      children: [
        

        Expanded(
          child: GridView.count(
            crossAxisCount: 2,
            children: List.generate(voyages.length,(index) => VoyageCard(index: index)),
          ) 
        )
      ]
    );
  }
}