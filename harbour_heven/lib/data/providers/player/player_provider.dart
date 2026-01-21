
import 'package:harbour_heven/data/hive/player_state.dart';
import 'package:harbour_heven/data/model/player/player.dart';
import 'package:harbour_heven/data/providers/player/mapper/player_mapper.dart';
import 'package:harbour_heven/data/providers/player/player_controller.dart';
import 'package:hive/hive.dart';

final playerProvider = playerProvider<PlayerController,Player>(() async {
   Box<PlayerState> playerStateBox = await Hive.openBox<PlayerState>('player');
   PlayerState? playerState = playerStateBox.getAt(0);
   PlayerMapper playerMapper = PlayerMapper();
   Player player;

  if(playerState == null) {player = Player.empty();}   
  else {player = playerMapper.fromState(playerState: playerState);}

  return player;
  
});