import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:harbour_heven/components/resource_display_card.dart';
import 'package:harbour_heven/components/voyage_result_dialog.dart';
import 'package:harbour_heven/data/model/building/voyage_port.dart';
import 'package:harbour_heven/data/model/enum/voyage_ship_type.dart';
import 'package:harbour_heven/data/model/voyage/voyage.dart';
import 'package:harbour_heven/data/model/voyage/voyage_result.dart';
import 'package:harbour_heven/data/providers/player/player_controller.dart';
import 'package:harbour_heven/data/providers/player/player_provider.dart';
class VoyageCard extends ConsumerStatefulWidget {
  const VoyageCard({super.key, required this.index});
  final int index;

  @override
  createState() => _VoyageCardState();
}

class _VoyageCardState extends ConsumerState<VoyageCard> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    VoyagePort voyagePort = ref.watch(
      playerProvider.select(
        (p) => p.buildings.whereType<VoyagePort>().first,
      ),
    );

    PlayerController playerController =
        ref.read(playerProvider.notifier);

    Voyage voyage = voyagePort.currentVoyages[widget.index];

    int totalBasePoints = 0;
    for (VoyageShipType ship in voyagePort.voyageShips.keys) {
      totalBasePoints +=
          voyagePort.voyageShips[ship]! * ship.basePoints;
    }

    double progress =
        (totalBasePoints / voyage.successThreshold).clamp(0.0, 1.0);

    return Card(
      elevation: 6,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  voyage.type.name,
                  style: theme.textTheme.titleLarge,
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: theme.colorScheme.primaryContainer,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    voyage.difficulty.name,
                    style: theme.textTheme.labelMedium,
                  ),
                ),
              ],
            ),

            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Success Chance",
                  style: theme.textTheme.labelMedium,
                ),
                const SizedBox(height: 8),
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: LinearProgressIndicator(
                    value: progress,
                    minHeight: 10,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  "${(progress * 100).toStringAsFixed(0)}%",
                  style: theme.textTheme.bodySmall,
                ),
              ],
            ),

            Column(
              children: [
                Text(
                  "Rewards",
                  style: theme.textTheme.titleMedium,
                ),
                ...voyage.recources.entries.map((e) => Padding(
                  padding: const EdgeInsets.only(bottom: 6),
                  child: ResourceDisplayCard(
                    resourceType: e.key,
                    amount: e.value,
                    ),
                  ),
              ),
            ]
            ),

            SizedBox(
              width: double.infinity,
              child: FilledButton(
                onPressed: () {
                final VoyageResult? voyageResult = playerController.performVoyage(index: widget.index);
                if(voyageResult == null || !voyagePort.voyageShips.values.any((e) => e > 0)) return;
                
                showDialog(
                  animationStyle: AnimationStyle(
                    duration: Duration(milliseconds: 250)
                  ),
                  context: context, 
                  builder: (context) =>  VoyageResultDialog(voyageResult: voyageResult),
                );
                },
                child: Text((voyagePort.voyageShips.values.any((e) => e > 0)) ? "Perform Voyage" : "Buy ships"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
