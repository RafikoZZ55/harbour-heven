import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:harbour_heven/data/providers/player/player_controller.dart';
import 'package:harbour_heven/data/providers/player/player_provider.dart';
import 'package:harbour_heven/views/offer_offer_view.dart';
import 'package:harbour_heven/views/offer_reputation_view.dart';

class OfferView extends ConsumerStatefulWidget {
  const OfferView({ super.key });

  @override
  createState() => _OfferViewState();
}

enum OfferViews {offers, tradingPortStatistics}

class _OfferViewState extends ConsumerState<OfferView> {
  OfferViews? _selectedOfferViewBtn;
  Widget?  _selectedOfferView;
  @override
  Widget build(BuildContext context) {
    PlayerController playerController = ref.read(playerProvider.notifier);

    _selectedOfferViewBtn ??= OfferViews.offers;
    if(_selectedOfferViewBtn == OfferViews.offers) {_selectedOfferView = OfferOfferView();}
    else {_selectedOfferView = OfferReputationView();}

    return Padding(
      padding: const EdgeInsets.all(8.00),
      child: Column(
        children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            FilledButton(
              onPressed: () => playerController.reRollOffers(),
              child: Text("Re-roll 🪙: -5")
            ),

            SizedBox(
              width: 250,
              child: SegmentedButton(
                segments: [
                  ButtonSegment(
                    value: OfferViews.offers,
                    label: Text("Offers"),
                  ),
                  ButtonSegment(
                    value: OfferViews.tradingPortStatistics,
                    label: Text("Reputation"),
                  ),
                ], 
                selected: {_selectedOfferViewBtn},
                onSelectionChanged: (selected) {
                  setState(() {
                    _selectedOfferViewBtn = selected.first;
                  });
                },
              ),
            )
          ],
        ),

        Expanded(
          child: AnimatedSwitcher(
            duration: Duration(milliseconds: 500),
            child: _selectedOfferView,
          )
        ),
        ],
      )
    );
  }
}