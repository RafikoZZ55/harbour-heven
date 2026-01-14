
import 'package:harbour_heven/data/model/enum/recource_type.dart';
import 'package:harbour_heven/data/model/enum/voyage_ship_type.dart';

abstract class VoyageShip {
  final VoyageShipType type;
  final String description;
  final double returnRate;
  final double basePoints;
  final Map<Recourcetype,int> price;

  VoyageShip({
    required this.type,
    required this.description,
    required this.returnRate,
    required this.basePoints,
    required this.price,
  });
}