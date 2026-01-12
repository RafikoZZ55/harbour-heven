import 'package:harbour_heven/data/model/building.dart';
import 'package:harbour_heven/data/model/recource_type.dart';

abstract class Generator extends Building{
  Generator({
    required super.level,
    required super.name,
    required super.description,
    required super.price,
  });

  Map<Recourcetype, double> generateRecources();
  
}