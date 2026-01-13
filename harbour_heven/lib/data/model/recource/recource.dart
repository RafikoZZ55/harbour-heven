
import 'package:harbour_heven/data/model/enum/recource_type.dart';

class Recource {
  final Recourcetype type;
  int quantity;
  int capacity;

  Recource({
    required this.type,
    required this.capacity,
    required this.quantity
  });

}