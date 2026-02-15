
import 'package:hive_flutter/hive_flutter.dart';

part 'generated/offer_state.g.dart';

@HiveType(typeId: 2)
class OfferState {
  @HiveField(0)
  final String type;

  @HiveField(1)
  final Map<String, int> reward;

  @HiveField(2)
  Map<String,int> price;

  @HiveField(3)
  bool isCompleted;

  @HiveField(4)
  bool canHaggle;

  @HiveField(5)
  final int maxHaggleGain;

  @HiveField(6)
  double patience;

  @HiveField(7)
  bool isFailed;


  OfferState({
    required this.type,
    required this.reward,
    required this.price,
    required this.isCompleted,
    required this.maxHaggleGain,
    required this.canHaggle,
    required this.patience,
    required this.isFailed,
  });
}