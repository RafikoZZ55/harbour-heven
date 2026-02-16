import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:harbour_heven/components/offer_card.dart';
import 'package:harbour_heven/data/model/barghter/offer.dart';
import 'package:harbour_heven/data/model/building/trading_port.dart';
import 'package:harbour_heven/data/providers/player/player_provider.dart';

class OfferOfferView extends ConsumerWidget {
const OfferOfferView({ super.key });

  @override
  Widget build(BuildContext context, WidgetRef ref){
    List<Offer> offers = ref.watch(
      playerProvider.select((p) => p.buildings.whereType<TradingPort>().first.currentOffers)
    );
    
    return ListView(
      semanticChildCount: offers.length,
      children: offers.map((e) => OfferCard(index: offers.indexOf(e))).toList(),
    );
  }
}