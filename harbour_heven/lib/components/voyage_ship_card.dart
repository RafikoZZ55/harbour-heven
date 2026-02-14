import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:harbour_heven/components/resource_display_card.dart';
import 'package:harbour_heven/data/model/building/voyage_port.dart';
import 'package:harbour_heven/data/model/enum/voyage_ship_type.dart';
import 'package:harbour_heven/data/providers/player/player_controller.dart';
import 'package:harbour_heven/data/providers/player/player_provider.dart';
class VoyageShipCard extends ConsumerStatefulWidget {
  const VoyageShipCard({
    super.key,
    required this.voyageShipType,
  });

  final VoyageShipType voyageShipType;

   @override
  createState() => _VoyageShipCard();

}

class _VoyageShipCard extends ConsumerState<VoyageShipCard> {
    
  @override
  Widget build(BuildContext context) {
    final playerController = ref.read(playerProvider.notifier);

    final shipsAmount = ref.watch(
      playerProvider.select(
        (p) => p.buildings
            .whereType<VoyagePort>()
            .first
            .voyageShips[widget.voyageShipType] ??
            0,
      ),
    );

    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  widget.voyageShipType.name.toUpperCase(),
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Chip(
                  label: Text("Owned: $shipsAmount"),
                )
              ],
            ),

            const SizedBox(height: 12),

            Text(
              widget.voyageShipType.description,
              style: TextStyle(
                color: Colors.grey[700],
              ),
            ),

            const SizedBox(height: 16),

            Text("Succes return rate: "),
            LinearProgressIndicator(
              value: widget.voyageShipType.returnRate,
              color: Colors.green,
            ),
            const SizedBox(height: 8),
            Text("Failure return rate: "),
            LinearProgressIndicator(
              value: widget.voyageShipType.returnRate / 2,
              color: Colors.red,
            ),

            const SizedBox(height: 8),
            Text(
              "Base Points: ${widget.voyageShipType.basePoints}",
              style: const TextStyle(fontWeight: FontWeight.w500),
            ),

            const SizedBox(height: 16),

            const Text(
              "Cost:",
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),

            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: widget.voyageShipType.buyPrice.entries
                  .map(
                    (e) => ResourceDisplayCard(
                      resourceType: e.key,
                      amount: e.value,
                    ),
                  )
                  .toList(),
            ),

            const SizedBox(height: 20),

            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: shipsAmount > 0
                        ? () => playerController.sellVoyageShip(voyageShipType: widget.voyageShipType): null,
                    child: const Text("SELL"),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: FilledButton(
                    onPressed: () => playerController.buyVoyageShip(type: widget.voyageShipType),
                    child: const Text("BUY"),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}