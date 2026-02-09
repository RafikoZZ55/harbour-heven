import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:harbour_heven/data/model/barghter/offer.dart';
import 'package:harbour_heven/data/model/building/trading_port.dart';
import 'package:harbour_heven/data/providers/player/player_controller.dart';
import 'package:harbour_heven/data/providers/player/player_provider.dart';

class OfferCard extends ConsumerStatefulWidget {
  const OfferCard({ super.key, required this.index });
  final int index;

  @override
  createState() => _OfferCardState();
}

class _OfferCardState extends ConsumerState<OfferCard> {
  @override
  Widget build(BuildContext context) {
    PlayerController playerController = ref.read(playerProvider.notifier);
    Offer offer = ref.watch(
      playerProvider.select((p) => p.buildings.whereType<TradingPort>().first.currentOffers[widget.index])
    );

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(2.5),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              offer.type.name.toString(),
              style: TextStyle(
                fontSize: 15,
              ),
            ),

            Text("reward"),
            ...offer.reward.entries.map((e) {
              return Text("${e.key.name}: ${e.value}");
            }),

            Text("price"),
            ...offer.price.entries.map((e) {
              return Text("${e.key.name}: ${e.value}");
            }),

            ElevatedButton(
              onPressed: () => playerController.trade(index: widget.index),
              style: ElevatedButton.styleFrom(
                fixedSize: const Size(double.infinity, 50)
              ), 
              child: Text(offer.isCompleted ? "traded" : "Trade")
            ),

          ],
        ),
      ),
    );
  }
}