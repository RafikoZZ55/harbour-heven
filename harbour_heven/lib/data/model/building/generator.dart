import 'package:harbour_heven/data/model/building/building.dart';
import 'package:harbour_heven/data/model/enum/recource_type.dart';

abstract class Generator extends Building{
  Recourcetype recourcetype;
  Generator({
    required super.level,
    required super.type,
    required super.description,
    required this.recourcetype,
    required super.price,
  });

  Map<Recourcetype, double> generateRecources();
  
}