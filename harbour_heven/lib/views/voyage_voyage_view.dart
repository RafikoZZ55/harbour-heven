import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:harbour_heven/components/voyage_card.dart';
import 'package:harbour_heven/data/model/building/voyage_port.dart';
import 'package:harbour_heven/data/providers/player/player_provider.dart';

class VoyageVoyageView extends ConsumerWidget {
  const VoyageVoyageView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final voyagePort = ref.watch(
      playerProvider.select(
        (e) => e.buildings.whereType<VoyagePort>().first,
      ),
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: ListView.builder(
            itemCount: voyagePort.currentVoyages.length,
            itemBuilder: (context, index) =>
                VoyageCard(index: index),
          ),
        ),
      ],
    );
  }
}
