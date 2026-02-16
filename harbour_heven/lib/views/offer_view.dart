import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:harbour_heven/data/model/building/trading_port.dart';
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
  Timer? _timer;
  String _formattedTime = "";

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(Duration(seconds: 1), (_) {
      final int nextRefreshAt = ref.watch(playerProvider.select(
        (p) => p.buildings.whereType<TradingPort>().first.nextRefreshAt
      ));
      final int currentDate = DateTime.now().millisecondsSinceEpoch;
      final int elapsed = nextRefreshAt - currentDate;
      final int hours = elapsed ~/ (1000 * 60 *60);
      final int minutes = elapsed ~/ (1000 * 60) % 60;
      final int seconds = elapsed ~/ (1000) % 60;

      setState(() {
        _formattedTime = "${hours}h ${minutes}m ${seconds}s";
      });
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final PlayerController playerController = ref.read(playerProvider.notifier);
    final scheme = Theme.of(context).colorScheme;
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

          const SizedBox(height: 8),
          SizedBox(
            width: double.infinity,
            child: Text(
              "  Next refresh: $_formattedTime",
              textAlign: TextAlign.start,
              style: TextStyle(
                fontSize: 12.5,
                color: scheme.primary,
                fontWeight: FontWeight.bold
              ),
              ),
          ),
          const SizedBox(height: 12),       

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