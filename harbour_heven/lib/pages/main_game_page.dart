import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:harbour_heven/components/main_game_bar.dart';
import 'package:harbour_heven/views/offer_view.dart';
import 'package:harbour_heven/views/production_view.dart';
import 'package:harbour_heven/views/town_view.dart';
import 'package:harbour_heven/views/voyage_view.dart';
class MainGamePage extends ConsumerStatefulWidget {
  const MainGamePage({super.key});

  @override
  ConsumerState<MainGamePage> createState() => _MainGamePageState();
}

class _MainGamePageState extends ConsumerState<MainGamePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MainGameBar(),
      body: DefaultTabController(
        length: 4,
        child: Column(
          children: const [
            Expanded(
              child: TabBarView(
                children: [
                  OfferView(),
                  TownView(),
                  VoyageView(),
                  ProductionView()
                ],
              ),
            ),
            TabBar(
              tabs: [
                Tab(text: "Trade"),
                Tab(text: "Town"),
                Tab(text: "voyage"),
                Tab(text: "Produce",)
              ],
            ),
          ],
        ),
      ),
    );
  }
}
