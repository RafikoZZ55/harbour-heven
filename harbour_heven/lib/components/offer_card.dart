import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:harbour_heven/components/resource_display_card.dart';
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
      int? _haggledPrice;
      Offer? _lastOffer;

      String _getStatus(Offer offer){
        if(offer.isCompleted) {return "Completed";}
        if(offer.isFailed) {return "Failed";}
        else {return "Trade";}
      }

  @override
  Widget build(BuildContext context) {
    PlayerController playerController = ref.read(playerProvider.notifier);
    Offer offer = ref.watch(playerProvider.select((p) => p.buildings.whereType<TradingPort>().first.currentOffers[widget.index]));
    ColorScheme sheme = Theme.of(context).colorScheme;
    _lastOffer ??= offer;
    if(_lastOffer != offer){
      _lastOffer = offer;
      _haggledPrice = _lastOffer!.price.values.first;
    }
    _haggledPrice ??= offer.price.values.first;

return Card(
  elevation: 6,
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(16),
  ),
  child: Padding(
    padding: const EdgeInsets.all(16),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        Text(
          offer.type.name,
          style: const TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),

        const SizedBox(height: 16),

        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            Expanded(
              flex: 3,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  const Text(
                    "Rewards",
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 8),

                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: offer.reward.entries
                        .map((e) => ResourceDisplayCard(
                              resourceType: e.key,
                              amount: e.value,
                            ))
                        .toList(),
                  ),

                  const SizedBox(height: 16),

                  const Text(
                    "Price",
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 8),

                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: offer.price.entries
                        .map((e) => ResourceDisplayCard(
                              resourceType: e.key,
                              amount: e.value,
                            ))
                        .toList(),
                  ),

                  const SizedBox(height: 16),

                  Slider(
                    value: _haggledPrice!.toDouble(),
                    min: 0,
                    max: offer.price.values.first.toDouble(),
                    divisions: offer.price.values.first,
                    label: _haggledPrice!.toString(),
                    onChanged: (value) {
                      offer.canHaggle && !offer.isCompleted ? 
                      setState(() => _haggledPrice = value.toInt()) : null;
                    },
                  ),
                ],
              ),
            ),

            const SizedBox(width: 24),

            Expanded(
              flex: 2,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [

                  Column(
                    children: [
                      Text(
                        "Patience: ${offer.patience.toStringAsFixed(2)}",
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: sheme.primary,
                        ),
                      ),
                      const SizedBox(height: 12),
                      SizedBox(
                        width: 90,
                        height: 90,
                        child: CircularProgressIndicator(
                          value: offer.patience,
                          strokeWidth: 10,
                          backgroundColor: sheme.secondary,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 24),

                  SizedBox(
                    width: double.infinity,
                    child: FilledButton(
                      onPressed: () => offer.canHaggle && !offer.isCompleted ?
                      playerController.trade(
                        index: widget.index, 
                        haggledPrice: _haggledPrice!,
                      ): null,
                      child: Text(_getStatus(offer)),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    ),
  ),
);

  }
}