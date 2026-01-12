

import 'package:harbour_heven/data/model/generator.dart';
import 'package:harbour_heven/data/model/recource_type.dart';

class FishingDock extends Generator {
  FishingDock({
    required super.level, 
    required super.name, 
    required super.description, 
    required super.price
  });

  @override
  Map<Recourcetype, double> generateRecources() {
    // TODO: implement generateRecources
    throw UnimplementedError();
  }

  @override
  Map<Recourcetype, int> upgradeCost() {
    // TODO: implement upgradeCost
    throw UnimplementedError();
  }

}