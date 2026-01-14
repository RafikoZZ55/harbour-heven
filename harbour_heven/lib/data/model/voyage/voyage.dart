
import 'package:harbour_heven/data/model/enum/difficulty.dart';
import 'package:harbour_heven/data/model/enum/recource_type.dart';

class Voyage {
  final Difficulty difficulty;
  final Map<Recourcetype,int> recources;
  final double successThreshold;

  Voyage({
    required this.difficulty,
    required this.recources,
    required this.successThreshold,
  });

}