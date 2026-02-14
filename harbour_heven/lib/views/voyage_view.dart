import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:harbour_heven/components/voyage_card.dart';
import 'package:harbour_heven/components/voyage_ship_card.dart';
import 'package:harbour_heven/data/model/building/voyage_port.dart';
import 'package:harbour_heven/data/providers/player/player_controller.dart';
import 'package:harbour_heven/data/providers/player/player_provider.dart';

class VoyageView extends ConsumerStatefulWidget {
  const VoyageView({ super.key });

  @override
  createState() => _VoyageViewState();
}

class _VoyageViewState extends ConsumerState<VoyageView> {
  @override
  Widget build(BuildContext context) {
    VoyagePort voyagePort = ref.watch(playerProvider.select(
      (e) => e.buildings.whereType<VoyagePort>().first
    ));
    PlayerController playerController = ref.read(playerProvider.notifier);

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Voyages",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              FilledButton(
                onPressed: () => playerController.reRollVoyages(),
                child: const Text("Re-roll voyages"),
              )
            ],
          ),

          const SizedBox(height: 12),

          Expanded(
            child: ListView(
              children: [
                ...voyagePort.voyageShips.entries.map(
                  (e) => Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: VoyageShipCard(voyageShipType: e.key),
                  ),
                ),

                const SizedBox(height: 16),
                const Divider(),
                const SizedBox(height: 16),
                GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: voyagePort.currentVoyages.length,
                  gridDelegate:
                      const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 1,
                    crossAxisSpacing: 8,
                    mainAxisSpacing: 8,
                  ),
                  itemBuilder: (context, index) =>
                      VoyageCard(index: index),
                ),
              ],
            ),
          ),
        ],
      ),
    );

  }
}