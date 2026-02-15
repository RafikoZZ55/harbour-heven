
import 'package:harbour_heven/data/model/enum/difficulty_type.dart';
import 'package:harbour_heven/data/model/enum/resource_type.dart';
import 'package:harbour_heven/data/model/enum/voyage_type.dart';

class Voyage {
  final VoyageType type;
  final DifficultyType difficulty;
  final Map<ResourceType,int> recources;
  final int successThreshold;

  Voyage({
    required this.type,
    required this.difficulty,
    required this.recources,
    required this.successThreshold,
  });


  Voyage copyWith({
    VoyageType? type,
    DifficultyType? difficulty,
    Map<ResourceType,int>? recources,
    int? successThreshold,
  }){
    return Voyage(
      type: type ?? this.type, 
      difficulty: difficulty ?? this.difficulty, 
      recources: recources ??  Map.from(this.recources), 
      successThreshold: successThreshold ?? this.successThreshold
    );
  }

}