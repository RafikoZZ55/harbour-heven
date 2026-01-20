import 'package:harbour_heven/data/hive/offer_state.dart';
import 'package:harbour_heven/data/hive/voyage_state.dart';
import 'package:hive_flutter/hive_flutter.dart';

part 'generated/building_state.g.dart';

@HiveType(typeId: 1)
class BuildingState {
  @HiveField(0)
  int level;

  @HiveField(1)
  String type;

  //voyage_port
  @HiveField(2)
  List<VoyageState>? currentVoyages;

  @HiveField(3)
  Map<String, int>? voyageShips;

  //trading_port
  @HiveField(4)
  double? reputation;

  @HiveField(5)
  List<OfferState>? currentOffers;

  BuildingState({
    required this.level,
    required this.type,
    this.currentVoyages,
    this.voyageShips,
    this.currentOffers,
    this.reputation,
    });
}