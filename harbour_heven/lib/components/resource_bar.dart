import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:harbour_heven/components/resource_display.dart';
import 'package:harbour_heven/data/providers/player/player_provider.dart';


class ResourceBar extends ConsumerWidget {
  const ResourceBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final playerResources = ref.watch(playerProvider.select((p) => p.resources));

    return SizedBox(
      height: 56,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 8),
        itemCount: playerResources.length,
        separatorBuilder: (_,_) => const SizedBox(width: 8),
        itemBuilder: (context, index) {
          final type = playerResources.keys.elementAt(index);
          return ResourceDisplay(resourceType: type);
        },
      ),
    );
  }
}
