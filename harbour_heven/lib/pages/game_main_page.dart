import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:harbour_heven/components/resource_bar.dart';
import 'package:harbour_heven/views/offer_view.dart';
import 'package:harbour_heven/views/production_view.dart';
import 'package:harbour_heven/views/town_view.dart';
import 'package:harbour_heven/views/voyage_view.dart';
class GameMainPage extends ConsumerStatefulWidget {
  const GameMainPage({super.key});

  @override
  ConsumerState<GameMainPage> createState() => _GameMainPageState();
}

class _GameMainPageState extends ConsumerState<GameMainPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        title: const ResourceBar(),
      ),
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
