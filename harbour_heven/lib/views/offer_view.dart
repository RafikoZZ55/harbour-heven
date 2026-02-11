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
      padding: const EdgeInsets.all(5),
      child: Column(
        children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Trading Port"),
            ElevatedButton(onPressed: () => playerController.reRollOffers(), child: Text("reRoll -5 gold"))
          ],
        ),

        Expanded(
          child: GridView.count(
            crossAxisCount: 2,
            mainAxisSpacing: 5,
            crossAxisSpacing: 5,
            scrollDirection: Axis.vertical,
            children: List.generate(offers.length, (index) => OfferCard(index: index,)),
          ),
        ),
        ],
      )
    );
  }
}