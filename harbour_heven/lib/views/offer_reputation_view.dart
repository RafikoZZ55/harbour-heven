import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:harbour_heven/data/model/building/trading_port.dart';
import 'package:harbour_heven/data/providers/player/player_provider.dart';

class OfferReputationView extends ConsumerWidget {
const OfferReputationView({ super.key });

  @override
  Widget build(BuildContext context, WidgetRef ref){
      final ColorScheme scheme = Theme.of(context).colorScheme;
    double reputation = ref.watch(playerProvider.select(
    (p) => p.buildings.whereType<TradingPort>().first.reputation 
    ));

    return Stack(
      alignment:  Alignment.center,
      children: [
        SizedBox(
          width: 200,
          height: 200,
          child: CircularProgressIndicator(
            value: reputation,
            backgroundColor: scheme.inversePrimary,
            strokeWidth: 20,
          ),
        ),
    
        Text(
          "Reputaion: \n ${(reputation * 100).toInt()}%",
          textAlign: TextAlign.center,
          style: TextStyle(
            color: scheme.primary,
            fontSize: 20,
            fontWeight: FontWeight.bold
          ),
        ),
      ],
    );
  }
}