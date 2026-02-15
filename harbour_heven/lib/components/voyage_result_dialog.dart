import 'package:flutter/material.dart';
import 'package:harbour_heven/components/resource_display_card.dart';
import 'package:harbour_heven/data/model/voyage/voyage_result.dart';

class VoyageResultDialog extends StatelessWidget {
  const VoyageResultDialog({
    super.key,
    required this.voyageResult,
  });

  final VoyageResult voyageResult;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    final bool success = voyageResult.isSucces;

    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      titlePadding: const EdgeInsets.only(top: 24),
      contentPadding: const EdgeInsets.fromLTRB(24, 16, 24, 8),
      actionsPadding: const EdgeInsets.only(bottom: 16),
      title: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              success ? Icons.emoji_events : Icons.warning_amber_rounded,
              size: 48,
            ),
            const SizedBox(height: 12),
            Text(
              success ? "Voyage Successful!" : "Voyage Failed",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
      content: ConstrainedBox(
        constraints: const BoxConstraints(maxHeight: 350),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              const SizedBox(height: 8),

              Text(
                "Rewards",
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: colorScheme.primary,
                ),
              ),
              const SizedBox(height: 8),

              if (voyageResult.resourcesGained.isEmpty || !voyageResult.isSucces)
                const Text("No rewards")
              else
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: voyageResult.resourcesGained.entries
                      .map((e) => ResourceDisplayCard(
                            resourceType: e.key,
                            amount: e.value,
                          ))
                      .toList(),
                ),

              const SizedBox(height: 20),

              Text(
                "Ships Lost",
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: colorScheme.primary,
                ),
              ),
              const SizedBox(height: 8),

              if (voyageResult.lostShips.isEmpty)
                const Text("No ships lost")
              else
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: voyageResult.lostShips.entries
                      .map(
                        (e) => Padding(
                          padding: const EdgeInsets.symmetric(vertical: 2),
                          child: Text(
                            "${e.key.name}: -${e.value}",
                            style: const TextStyle(
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      )
                      .toList(),
                ),
            ],
          ),
        ),
      ),
      actionsAlignment: MainAxisAlignment.center,
      actions: [
        SizedBox(
          child: FilledButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("       Continue       "),
          ),
        ),
      ],
    );
  }
}
