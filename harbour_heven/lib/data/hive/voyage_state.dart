
import 'package:hive_flutter/hive_flutter.dart';

part 'generated/voyage_state.g.dart';

@HiveType(typeId: 3)
class VoyageState {
  @HiveField(0)
  final String type;

  @HiveField(1)
  final String difficulty;

  @HiveField(2)
  final Map<String,int> resources;

  @HiveField(3)
  final int successThreshold;

  VoyageState({
    required this.type,
    required this.difficulty,
    required this.resources,
    required this.successThreshold,
  });

}