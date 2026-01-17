
import 'package:harbour_heven/data/model/enum/offer_type.dart';
import 'package:harbour_heven/data/model/enum/recource_type.dart';

class Offer {
  final OfferType type;
  Map<RecourceType, int> reward;
  Map<RecourceType,int> price;
  bool isCompleted;


  Offer({
    required this.type,
    required this.reward,
    required this.price,
    required this.isCompleted,
  });
}