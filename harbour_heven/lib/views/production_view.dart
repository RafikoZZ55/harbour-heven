import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:harbour_heven/data/model/enum/resource_type.dart';
import 'package:harbour_heven/data/providers/player/player_controller.dart';
import 'package:harbour_heven/data/providers/player/player_provider.dart';

class ProductionView extends ConsumerStatefulWidget {
  const ProductionView({ super.key });

  @override
  createState() => _ProductionViewState();
}

class _ProductionViewState extends ConsumerState<ProductionView> {

  @override
  Widget build(BuildContext context) {
    final PlayerController playerController = ref.read(playerProvider.notifier);
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        spacing: 10,
        children: [
           Card(
            color: const Color.fromARGB(255, 25, 183, 189),
            elevation: 6,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(14),
            ),
            child: InkWell(
              borderRadius: BorderRadius.circular(14),
              onTap: () {
                playerController.produceRecource(
                  resourceType: ResourceType.fish,
                );
              },
              child: SizedBox(
              width: double.infinity,
              height: 200,
              child: Center(
                child: Text(
                   "🐟",
                    style: const TextStyle(
                      fontSize: 100,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ),

          Card(
            color: const Color.fromARGB(255, 59, 51, 27),
            elevation: 6,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(14),
            ),
            child: InkWell(
              borderRadius: BorderRadius.circular(14),
              onTap: () {
                playerController.produceRecource(
                  resourceType: ResourceType.wood,
                );
              },
              child: SizedBox(
              width: double.infinity,
              height: 200,
              child: Center(
                child: Text(
                   "🌳",
                    style: const TextStyle(
                      fontSize: 100,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ),

           Card(
            color: const Color.fromARGB(255, 100, 100, 100),
            elevation: 6,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(14),
            ),
            child: InkWell(
              borderRadius: BorderRadius.circular(14),
              onTap: () {
                playerController.produceRecource(
                  resourceType: ResourceType.stone,
                );
              },
              child: SizedBox(
              width: double.infinity,
              height: 200,
              child: Center(
                child: Text(
                   "🪨",
                    style: const TextStyle(
                      fontSize: 100,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}