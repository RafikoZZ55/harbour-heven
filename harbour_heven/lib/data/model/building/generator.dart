import 'package:harbour_heven/data/model/building/building.dart';
import 'package:harbour_heven/data/model/enum/resource_type.dart';

abstract class Generator extends Building{
  ResourceType recourcetype;
  Generator({
    required super.level,
    required super.type,
    required super.description,
    required this.recourcetype,
    required super.price,
  });

  Map<ResourceType, int> calculateRecourcesPerCycle();
  
}