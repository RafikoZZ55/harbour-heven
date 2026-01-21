
import 'package:flutter_riverpod/legacy.dart';
import 'package:harbour_heven/data/hive/player_state.dart';
import 'package:harbour_heven/data/model/player/player.dart';
import 'package:harbour_heven/data/providers/player/mapper/player_mapper.dart';
import 'package:hive_flutter/adapters.dart';

class PlayerController extends StateNotifier<Player> {
  PlayerController(super.state);
  Box<PlayerState> playerStateBox = Hive.box<PlayerState>('player');

  void _load

  void _save() async { 
    PlayerMapper playerMapper = PlayerMapper();
    PlayerState playerState = playerMapper.toState(player: state);

    playerStateBox.put('player', playerState);
  }

  

}