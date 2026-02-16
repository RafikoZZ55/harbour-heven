import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:harbour_heven/components/voyage_ship_card.dart';
import 'package:harbour_heven/data/model/building/voyage_port.dart';
import 'package:harbour_heven/data/providers/player/player_provider.dart';

class VoyageShipsView extends ConsumerWidget {
  const VoyageShipsView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final voyagePort = ref.watch(
      playerProvider.select(
        (e) => e.buildings.whereType<VoyagePort>().first,
      ),
    );

    return ListView(
      children: voyagePort.voyageShips.entries.map(
        (e) => Padding(
          padding: const EdgeInsets.only(bottom: 8),
          child: VoyageShipCard(voyageShipType: e.key),
        ),
      ).toList(),
    );
  }
}
