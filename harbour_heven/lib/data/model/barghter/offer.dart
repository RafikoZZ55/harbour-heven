
import 'package:harbour_heven/data/model/enum/offer_type.dart';
import 'package:harbour_heven/data/model/enum/resource_type.dart';

class Offer {
  final OfferType type;
  final Map<ResourceType, int> reward;
  Map<ResourceType,int> price;
  bool isCompleted;
  bool canHaggle;
  final int maxHaggleGain;
  double patience;


  Offer({
    required this.type,
    required this.reward,
    required this.price,
    required this.isCompleted,
    required this.maxHaggleGain,
    required this.canHaggle,
    required this.patience
  });
}