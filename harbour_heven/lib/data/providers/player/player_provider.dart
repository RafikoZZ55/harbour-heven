
import 'package:harbour_heven/data/model/player/player.dart';
import 'package:harbour_heven/data/providers/player/player_controller.dart';

final playerProvider = playerProvider<PlayerController,Player>((ref){
  return PlayerController(ref);
});