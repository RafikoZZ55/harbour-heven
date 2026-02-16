import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:harbour_heven/data/model/building/building.dart';
import 'package:harbour_heven/data/model/building/generator.dart';
import 'package:harbour_heven/data/model/player/player.dart';
import 'package:harbour_heven/data/providers/player/player_controller.dart';
import 'package:harbour_heven/data/providers/player/player_provider.dart';


class BuildingCard extends ConsumerStatefulWidget {
  const BuildingCard({
    super.key,
    required this.buidingIndex,
  });

  final int buidingIndex;

  @override
  ConsumerState<BuildingCard> createState() => _BuildingCardState();
}
class _BuildingCardState extends ConsumerState<BuildingCard> {
  double progres = 0;
  Timer? _timer;

  @override
  void initState() {
    super.initState();

    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (!mounted) return;

      setState(() {
        final Player player = ref.read(playerProvider);
        int current = DateTime.now().millisecondsSinceEpoch;
        int elapsed = current - player.lastTickAt;
        int total = PlayerController.tickTimeInMilliseconds;
        progres = (elapsed / total).clamp(0.0, 1.0);
      });
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Player player = ref.watch(playerProvider);
    final Building building = player.buildings[widget.buidingIndex];
    final PlayerController playerController = ref.read(playerProvider.notifier);
    final scheme = Theme.of(context).colorScheme;

    return Card(
      elevation: 2,
      color: scheme.surface,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14),
      ),
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  building.type.name,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: scheme.primaryContainer,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    'Lvl ${building.level}',
                    style: TextStyle(
                      color: scheme.onPrimaryContainer,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              building.description,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: scheme.onSurfaceVariant,
                  ),
            ),
            const SizedBox(height: 12),
            building is Generator ? LinearProgressIndicator(
              value: progres,
              minHeight: 7.5,
            ):

            const SizedBox(height: 12),
            Text(
              'Upgrade cost',
              style: Theme.of(context).textTheme.labelLarge,
            ),
            const SizedBox(height: 4),
            Wrap(
              spacing: 8,
              runSpacing: 4,
              children: building.upgradeCost().entries.map((entry) {
                return Chip(
                  label: Text('${entry.key.icon}: ${entry.value}'),
                  backgroundColor: scheme.secondaryContainer,
                  labelStyle: TextStyle(
                    color: scheme.onSecondaryContainer,
                  ),
                );
              }).toList(),
            ),
            const SizedBox(height: 12),
            Align(
              alignment: Alignment.centerRight,
              child: FilledButton(
                onPressed: () {
                  playerController.upgradeBuilding(index: widget.buidingIndex);
                },
                child: const Text('Upgrade'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
