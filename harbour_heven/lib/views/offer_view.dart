import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:harbour_heven/components/offer_card.dart';
import 'package:harbour_heven/data/model/barghter/offer.dart';
import 'package:harbour_heven/data/model/building/trading_port.dart';
import 'package:harbour_heven/data/providers/player/player_controller.dart';
import 'package:harbour_heven/data/providers/player/player_provider.dart';

class OfferView extends ConsumerStatefulWidget {
  const OfferView({ super.key });

  @override
  createState() => _OfferViewState();
}

class _OfferViewState extends ConsumerState<OfferView> {
  @override
  Widget build(BuildContext context) {
    PlayerController playerController = ref.read(playerProvider.notifier);
    List<Offer> offers = ref.watch(
      playerProvider.select((p) => p.buildings.whereType<TradingPort>().first.currentOffers)
    );

    return Padding(
      padding: const EdgeInsets.all(8.00),
      child: Column(
        children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Trading Port",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            FilledButton(
              onPressed: () => playerController.reRollOffers(),
              child: Text("Re-roll 🪙: -5"))
          ],
        ),

        Expanded(
          child: ListView(
            semanticChildCount: offers.length,
            children: offers.map((e) => OfferCard(index: offers.indexOf(e))).toList(),
          ),
        ),
        ],
      )
    );
  }
}