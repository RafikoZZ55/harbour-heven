import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:harbour_heven/data/model/barghter/offer.dart';
import 'package:harbour_heven/data/model/building/trading_port.dart';
import 'package:harbour_heven/data/providers/player/player_controller.dart';
import 'package:harbour_heven/data/providers/player/player_provider.dart';

class OfferPage extends ConsumerStatefulWidget {
  const OfferPage({super.key, required this.offerIndex});
  final int offerIndex;

  @override
  createState() => _OfferPageState();
}

class _OfferPageState extends ConsumerState<OfferPage> {
  int? hugglePrice;

  @override
  Widget build(BuildContext context) {
    ColorScheme colorScheme = Theme.of(context).colorScheme;
    PlayerController playerController = ref.read(playerProvider.notifier);

    Offer offer = ref.watch(playerProvider.select(
      (p) => p.buildings.whereType<TradingPort>().first.currentOffers[widget.offerIndex],
    ));

    hugglePrice ??= offer.price.values.first;

    int maxPrice = offer.price.values.first;
    int minPrice = 0; 

    return Scaffold(
      appBar: AppBar(
        title: Text(offer.type.name),
        backgroundColor: colorScheme.primary,
        titleTextStyle: TextStyle(color: colorScheme.onPrimary, fontSize: 25),
        iconTheme: IconThemeData(color: colorScheme.onPrimary, size: 25),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text("Rewards", style: TextStyle(fontWeight: FontWeight.bold)),
            ...offer.reward.entries
                .map((e) => Text("${e.key.name}: ${e.value}")),
            const Divider(),

            Text("Price", style: TextStyle(fontWeight: FontWeight.bold)),
            ...offer.price.entries
                .map((e) => Text("${e.key.name}: ${e.value}")),
            const Divider(),


            Text("Patience: ${(offer.patience * 100).toStringAsFixed(0)}%"),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: LinearProgressIndicator(
                value: offer.patience,
                minHeight: 10,
                backgroundColor: colorScheme.secondary,
                color: colorScheme.primary,
              ),
            ),
            const Divider(),


            Text("Haggle Price: $hugglePrice"),
            Slider(
              min: minPrice.toDouble(),
              max: maxPrice.toDouble(),
              value: hugglePrice!.toDouble(),
              onChanged: (offer.canHaggle || !offer.isCompleted)
                  ? (value) {
                      setState(() {
                        hugglePrice = value.toInt();
                      });
                    }
                  : null,
              divisions: maxPrice - minPrice,
              label: "$hugglePrice",
            ),
            const Divider(),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FilledButton(
                  onPressed: offer.canHaggle
                      ? () {
                          playerController.haggle(
                              index: widget.offerIndex, amount: hugglePrice!);
                          setState(() => hugglePrice = offer.price.values.first );
                        }
                      : null,
                  child: Text(offer.canHaggle ? "Haggle" : "Non tradable"),
                ),
                FilledButton(
                  onPressed: offer.canHaggle
                      ? () {
                          playerController.haggle(
                              index: widget.offerIndex, amount: hugglePrice!);
                          setState(() {
                            hugglePrice = offer.price.values.first;
                          });
                        }
                      : null,
                  child: Text(offer.isCompleted ? "Completed" : "Trade"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
