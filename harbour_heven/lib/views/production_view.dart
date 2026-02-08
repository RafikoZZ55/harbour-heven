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
            color: const Color.fromARGB(255, 64, 114, 116),
            elevation: 2,
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
                   "Fish",
                    style: const TextStyle(
                      fontSize: 35,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ),

          Card(
            color: const Color.fromARGB(255, 131, 112, 56),
            elevation: 2,
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
                   "Wood",
                    style: const TextStyle(
                      fontSize: 35,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ),

           Card(
            color: const Color.fromARGB(255, 88, 87, 81),
            elevation: 2,
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
                   "Stone",
                    style: const TextStyle(
                      fontSize: 35,
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