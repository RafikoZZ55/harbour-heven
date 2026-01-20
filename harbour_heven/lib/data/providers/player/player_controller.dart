
import 'package:flutter_riverpod/legacy.dart';
import 'package:harbour_heven/data/model/player/player.dart';

class PlayerController extends StateNotifier<Player> {
  PlayerController(super.state);

  void _save() => state = state.copyWith();
  

}