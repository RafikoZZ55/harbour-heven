import 'package:harbour_heven/data/hive/offer_state.dart';
import 'package:harbour_heven/data/hive/voyage_state.dart';
import 'package:hive_flutter/hive_flutter.dart';

part 'generated/building_state.g.dart';

@HiveType(typeId: 1)
class BuildingState {
  @HiveField(0)
  int level;

  //voyage_port
  @HiveField(1)
  List<VoyageState>? currentVoyages;

  @HiveField(2)
  Map<String, int>? voyageShips;

  //trading_port
  @HiveField(3)
  double? reputation;

  @HiveField(4)
  List<OfferState>? currentOffers;

  BuildingState({
    required this.level,
    this.currentVoyages,
    this.voyageShips,
    this.currentOffers,
    this.reputation,
    });
}