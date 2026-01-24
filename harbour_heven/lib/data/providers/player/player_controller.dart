
import 'dart:async';

import 'package:flutter_riverpod/legacy.dart';
import 'package:harbour_heven/data/hive/player_state.dart';
import 'package:harbour_heven/data/model/building/trading_port.dart';
import 'package:harbour_heven/data/model/building/voyage_port.dart';
import 'package:harbour_heven/data/model/enum/building_type.dart';
import 'package:harbour_heven/data/model/enum/voyage_ship_type.dart';
import 'package:harbour_heven/data/model/player/player.dart';
import 'package:harbour_heven/data/providers/player/mapper/player_mapper.dart';
import 'package:hive_flutter/adapters.dart';

class PlayerController extends StateNotifier<Player> {
  PlayerController(super.state) { _init();}

  void _refresh() => state = state.copyWith();
   late Timer _timer;

  void _save() async { 
    Box<PlayerState> playerStateBox = Hive.box<PlayerState>('player');
    _refresh();
    PlayerMapper playerMapper = PlayerMapper();
    PlayerState playerState = playerMapper.toState(player: state);

    playerStateBox.put('player', playerState);
  }

  //--------------------------------offers----------------------------------

  TradingPort _getTradingPort() {
    return state.buildings.firstWhere((b) => b.type == BuildingType.tradingPort) as TradingPort;
  }

  void trade({required int offerIndex}){
    state.trade(index: offerIndex);
    _save();
  }

  void haggle({required int offerIndex, required int amount}){
    state.haggle(index: offerIndex, amount: amount);
    _save();
  }

  void _reRollOffers(){
    state.reRollOffers();
    _getTradingPort().nextRefreshAt = DateTime.now().add(Duration(hours: 1)).millisecondsSinceEpoch;
    _save();
  }

  //-------------------------------------------------------------------------

  //------------------------------voyages------------------------------------

  VoyagePort _getVoyagePort() {
    return state.buildings.firstWhere((b) => b.type == BuildingType.voyagePort) as VoyagePort;
  }

  void buyVoyageShip({required VoyageShipType type}) {
    state.buyVoyageShip(type: type);
    _save();
  }

  void performVoyage({required int index}){
    state.performVoyage(index: index);
    _save();
  }

  void _reRollVoyages(){
    state.reRollVoyages();
    _getVoyagePort().nextRefreshAt = DateTime.now().add(Duration(hours: 1)).millisecondsSinceEpoch;
    _save();
  }
  //-------------------------------------------------------------------------


  void _performCycle({required int? cycles}){
    state.performCycle(cycles: cycles);
    _save();
  }

  void _load(){
    state.performCycle(cycles: _calculateCycles());
    _save();
  }

  Future<Player> _loadFromHive() async{
    Box<PlayerState> playerStateBox = await Hive.openBox<PlayerState>('player');
   PlayerState? playerState = playerStateBox.get('player');
   PlayerMapper playerMapper = PlayerMapper();
   Player player;

  if(playerState == null) {player = Player.empty();}   
  else {player = playerMapper.fromState(playerState: playerState);}

  return player;
  }

  int _calculateCycles(){
    return ((state.lastTickAt - DateTime.now().millisecondsSinceEpoch) / (1000 * 60)).toInt();
  }

  void _onTick(){
    int currentTime = DateTime.now().millisecondsSinceEpoch;
    _performCycle(cycles: 1);

    if(_getTradingPort().nextRefreshAt <= currentTime){ _reRollOffers();}
    if(_getVoyagePort().nextRefreshAt <= currentTime) {_reRollVoyages();}
    state = state.copyWith(lastTickAt: DateTime.now().millisecondsSinceEpoch);
    _save();
  }

  void _startTimer(){
    _timer = Timer.periodic(const Duration(minutes: 1), (_) => _onTick());
  }

  void _init() async{
    Player player = await _loadFromHive();
    state = player;
    _load();
    _startTimer();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }




}