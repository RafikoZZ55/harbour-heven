
import 'package:flutter_riverpod/legacy.dart';
import 'package:harbour_heven/data/model/player/player.dart';
import 'package:harbour_heven/data/providers/player/player_controller.dart';

final playerProvider =  StateNotifierProvider<PlayerController,Player>((_) {
   return PlayerController(Player.empty());
  
});