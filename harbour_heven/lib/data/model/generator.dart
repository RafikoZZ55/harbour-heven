import 'package:harbour_heven/data/model/building.dart';

abstract class Generator extends Building{
  double baseRecourcesPerCycle;

  Generator({
    required super.level,
    required super.name,
    required super.description,
    required super.price,
    required this.baseRecourcesPerCycle,
  });

  
}