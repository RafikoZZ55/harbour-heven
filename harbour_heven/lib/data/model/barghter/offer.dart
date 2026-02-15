
import 'package:harbour_heven/data/model/enum/offer_type.dart';
import 'package:harbour_heven/data/model/enum/resource_type.dart';

class Offer {
  final OfferType type;
  final Map<ResourceType, int> reward;
  Map<ResourceType,int> price;
  bool isCompleted;
  bool canHaggle;
  bool isFailed;
  final int maxHaggleGain;
  double patience;


  Offer({
    required this.type,
    required this.reward,
    required this.price,
    required this.isCompleted,
    required this.maxHaggleGain,
    required this.canHaggle,
    required this.patience,
    required this.isFailed,
  });


  Offer copyWith({
    OfferType? type,
    Map<ResourceType, int>? reward,
    Map<ResourceType,int>? price,
    bool? isCompleted,
    bool? isFailed,
    int? maxHaggleGain,
    bool? canHaggle,
    double? patience
  }){
    return Offer(
      type: type ?? this.type, 
      reward: reward ?? Map.from(this.reward), 
      price: price ?? Map.from(this.price), 
      isCompleted: isCompleted ?? this.isCompleted, 
      maxHaggleGain: maxHaggleGain ?? this.maxHaggleGain, 
      canHaggle: canHaggle ?? this.canHaggle, 
      patience: patience ?? this.patience,
      isFailed: isFailed ?? this.isFailed,
    );
  }
}