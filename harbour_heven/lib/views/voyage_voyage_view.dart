import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:harbour_heven/components/voyage_card.dart';
import 'package:harbour_heven/data/model/building/voyage_port.dart';
import 'package:harbour_heven/data/providers/player/player_provider.dart';

class VoyageVoyageView extends ConsumerStatefulWidget {
  const VoyageVoyageView({ Key? key }) : super(key: key);

  @override
  createState() => _VoyageVoyageViewState();
}

class _VoyageVoyageViewState extends ConsumerState<VoyageVoyageView> {
  @override
  Widget build(BuildContext context) {

    VoyagePort voyagePort = ref.watch(playerProvider.select(
      (e) => e.buildings.whereType<VoyagePort>().first
    ));

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 2.5,
      children: [
        Expanded(
          child: ListView(
            children: voyagePort.currentVoyages.map((e) => VoyageCard(index: voyagePort.currentVoyages.indexOf(e))).toList(),
          ),
        ),
      ],
    );
  }
}