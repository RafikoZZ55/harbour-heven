
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:harbour_heven/data/model/enum/resource_type.dart';
import 'package:harbour_heven/data/model/player/player.dart';
import 'package:harbour_heven/data/providers/player/player_provider.dart';

class ResourceDisplay extends ConsumerStatefulWidget {
  const ResourceDisplay({super.key,required this.resourceType});
    final ResourceType resourceType; 


  @override
  createState() => _ResourceDisplayState();
}

class _ResourceDisplayState extends ConsumerState<ResourceDisplay> {
  @override
  Widget build(BuildContext context){
    final ColorScheme sheme = Theme.of(context).colorScheme;
    Player player = ref.watch(playerProvider);


    return Padding(
      padding: const EdgeInsets.all(2.5),
      child: Container(
        decoration: BoxDecoration(
          color: sheme.primaryContainer,
          borderRadius: BorderRadius.all(Radius.elliptical(5, 5))
        ),
        child: Padding(
          padding: const EdgeInsets.all(2.0),
          child: Text(
            "${widget.resourceType.name}: ${player.resources[widget.resourceType]}/${player.calculateCapacity(resourceType: widget.resourceType)}",
            style: TextStyle(
              color: sheme.onPrimaryContainer,
              fontSize: 15
            ),
            ),
        ),
      ),
    );
  }
}