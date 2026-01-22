
import 'package:flutter_riverpod/legacy.dart';
import 'package:harbour_heven/data/hive/player_state.dart';
import 'package:harbour_heven/data/model/enum/voyage_ship_type.dart';
import 'package:harbour_heven/data/model/player/player.dart';
import 'package:harbour_heven/data/providers/player/mapper/player_mapper.dart';
import 'package:hive_flutter/adapters.dart';

class PlayerController extends StateNotifier<Player> {
  PlayerController(super.state);
  Box<PlayerState> playerStateBox = Hive.box<PlayerState>('player');

  void _refresh() => state = state.copyWith();

  void _save() async { 
    _refresh();
    PlayerMapper playerMapper = PlayerMapper();
    PlayerState playerState = playerMapper.toState(player: state);

    playerStateBox.put('player', playerState);
  }

  //--------------------------------offers----------------------------------
  void trade({required int offerIndex}){
    state.trade(index: offerIndex);
    _save();
  }

  void haggle({required int offerIndex, required int amount}){
    state.haggle(index: offerIndex, amount: amount);
    _save();
  }

  void reRollOffers(){
    state.reRollOffers();
    _save();
  }

  //-------------------------------------------------------------------------

  //------------------------------voyages------------------------------------
  void buyVoyageShip({required VoyageShipType type}) {
    state.buyVoyageShip(type: type);
    _save();
  }

  void performVoyage({required int index}){
    state.performVoyage(index: index);
    _save();
  }

  void generateVoyages(){
    state.reRollVoyages();
    _save();
  }

  void reRollVoyages(){
    state.reRollVoyages();
    _save();
  }
  //-------------------------------------------------------------------------


  void atutomaticReRoll(){
    state.reRollOffers();
    state.reRollVoyages();
    _save();
  }

  void performCycle({required int? cycles}){
    state.performCycle(cycles: cycles);
    _save();
  }

  void load(){
    int cycles = state.calculateCycles(cycleInMillisecons: 1000);
    state.performCycle(cycles: cycles);
    _save();
  }




}