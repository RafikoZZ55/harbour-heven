
import 'package:hive_flutter/hive_flutter.dart';

part 'generated/offer_state.g.dart';

@HiveType(typeId: 2)
class OfferState {
  @HiveField(1)
  final String type;

  @HiveField(2)
  final Map<String, int> reward;

  @HiveField(3)
  Map<String,int> price;

  @HiveField(4)
  bool isCompleted;

  @HiveField(5)
  bool canHaggle;

  @HiveField(6)
  final int maxHaggleGain;

  @HiveField(7)
  double patience;


  OfferState({
    required this.type,
    required this.reward,
    required this.price,
    required this.isCompleted,
    required this.maxHaggleGain,
    required this.canHaggle,
    required this.patience
  });
}