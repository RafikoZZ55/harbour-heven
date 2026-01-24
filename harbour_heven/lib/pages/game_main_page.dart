import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:harbour_heven/components/recource_display.dart';
import 'package:harbour_heven/data/model/enum/recource_type.dart';
import 'package:harbour_heven/data/model/player/player.dart';
import 'package:harbour_heven/data/providers/player/player_provider.dart';
import 'package:harbour_heven/views/offer_view.dart';
import 'package:harbour_heven/views/town_view.dart';
import 'package:harbour_heven/views/voyage_view.dart';

class GameMainPage extends ConsumerStatefulWidget {
  const GameMainPage({ super.key });

  @override
  createState() => _GameMainPageState();
}

class _GameMainPageState extends ConsumerState<GameMainPage> {
  @override
  Widget build(BuildContext context) {
  late Player player = ref.watch(playerProvider);

    List<RecourceDisplay> recourceDisplay = [];

    for (RecourceType recourceType in player.recources.keys) {
      recourceDisplay.add(
        RecourceDisplay(
          recourceType: recourceType, 
          amount: player.recources[recourceType] ?? 0
        )
      );
    }

    return Scaffold(
      appBar: AppBar(
        actionsPadding: EdgeInsets.all(4),
        actions: recourceDisplay,
      ),
      body: DefaultTabController(
        length: 3, 
        child: Column(
          children: [
          Expanded(
            child: TabBarView(children: [
              OfferView(),
              TownView(),
              VoyageView(),
            ])
            ),

            const TabBar(
            tabs: [
              Tab(text: "Trading"),
              Tab(text: "Town"),
              Tab(text: "Exploration"),
            ]),
          ],
          
        )
      )
    );
  }
}