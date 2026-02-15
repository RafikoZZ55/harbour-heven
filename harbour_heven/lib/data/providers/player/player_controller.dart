import 'dart:async';
import 'dart:math';
import 'package:flutter_riverpod/legacy.dart';
import 'package:harbour_heven/data/hive/player_state.dart';
import 'package:harbour_heven/data/model/building/building.dart';
import 'package:harbour_heven/data/model/building/tawern.dart';
import 'package:harbour_heven/data/model/building/trading_port.dart';
import 'package:harbour_heven/data/model/building/voyage_port.dart';
import 'package:harbour_heven/data/model/enum/building_type.dart';
import 'package:harbour_heven/data/model/enum/resource_type.dart';
import 'package:harbour_heven/data/model/enum/voyage_ship_type.dart';
import 'package:harbour_heven/data/model/player/player.dart';
import 'package:harbour_heven/data/model/voyage/voyage_result.dart';
import 'package:harbour_heven/data/providers/player/mapper/player_mapper.dart';
import 'package:hive_flutter/adapters.dart';

class PlayerController extends StateNotifier<Player> {
  PlayerController() : super(Player.empty());

  Timer? _tickTimer;
  Timer? _autoSaveTimer;

  bool _initialized = false;
  static const int tickTimeInMilliseconds = 1 * 1000 * 15;

  // ================= INIT =================
  Future<void> init() async {
    if (_initialized) return;
    _initialized = true;

    final loadedPlayer = await _loadFromHive();
    state = loadedPlayer;

    _applyOfflineProgress();
    _startTickTimer();
    _startAutoSave();
  }

  // ================= TIMERS =================
  void _startTickTimer() {
    _tickTimer = Timer.periodic(
      const Duration(milliseconds: tickTimeInMilliseconds),
      (_) => _onTick(),
    );
  }

  void _startAutoSave() {
    _autoSaveTimer = Timer.periodic(
      const Duration(seconds: 17),
      (_) => _save(),
    );
  }

  // ================= TICK =================
  void _onTick() {
    Player player = state.copyWith();
  
    final now = DateTime.now().millisecondsSinceEpoch;
    player.performCycle(cycles: 1);

    TradingPort tradingPort = player.buildings.firstWhere((b) => b.type == BuildingType.tradingPort) as TradingPort;
    if (tradingPort.nextRefreshAt <= now) {
      player.generateOffers();
      
      TradingPort updatedPort = player.buildings.firstWhere((b) => b.type == BuildingType.tradingPort) as TradingPort;
      int portIndex = player.buildings.indexOf(updatedPort);
      TradingPort refreshedPort = updatedPort.copyWith(
        nextRefreshAt: DateTime.now().add(const Duration(hours: 1)).millisecondsSinceEpoch
      );
      List<Building> updatedBuildings = List.from(player.buildings);
      updatedBuildings[portIndex] = refreshedPort;
      player.buildings = updatedBuildings;
    }

    VoyagePort voyagePort = player.buildings.firstWhere((b) => b.type == BuildingType.voyagePort) as VoyagePort;
    if (voyagePort.nextRefreshAt <= now) {
      player.generateVoyages();
      
      VoyagePort updatedPort = player.buildings.firstWhere((b) => b.type == BuildingType.voyagePort) as VoyagePort;
      int portIndex = player.buildings.indexOf(updatedPort);
      VoyagePort refreshedPort = updatedPort.copyWith(
        nextRefreshAt: DateTime.now().add(const Duration(hours: 1)).millisecondsSinceEpoch
      );
      List<Building> updatedBuildings = List.from(player.buildings);
      updatedBuildings[portIndex] = refreshedPort;
      player.buildings = updatedBuildings;
    }

    player.lastTickAt = now;
    state = player;
  }

  // ================= OFFLINE =================
  void _applyOfflineProgress() {
    final cycles = _calculateOfflineCycles();
    if (cycles > 0) {
      Player player = state.copyWith();
      player.performCycle(cycles: cycles);
      state = player;
    }
  }

  int _calculateOfflineCycles() {
    final now = DateTime.now().millisecondsSinceEpoch;
    final diff = now - state.lastTickAt;
    if (diff <= 0) return 0;

    const maxCycles = 1440;
    return min(diff ~/ 60000, maxCycles);
  }

  // ================= SAVE / LOAD =================
  Future<void> _save() async {
    final box = Hive.box<PlayerState>('player');
    final mapper = PlayerMapper();
    box.put('player', mapper.toState(player: state));
    state = state.copyWith();
  }

  Future<Player> _loadFromHive() async {
    final box = await Hive.openBox<PlayerState>('player');
    final saved = box.get('player');
    if (saved == null) return Player.empty();

    return PlayerMapper().fromState(playerState: saved);
  }

  // ================= ACTIONS =================

  void sellVoyageShip({required VoyageShipType voyageShipType}){
    Player player = state.copyWith();
    player.sellVoyageShip(type: voyageShipType);
    state = player;
    _save();
  }

  void trade({required int index, required int haggledPrice}) {
    Player player = state.copyWith();
    player.haggle(index: index, hagglePrice: haggledPrice);
    state = player;
    _save();
  }

  void buyVoyageShip({required VoyageShipType type}) {
    Player player = state.copyWith();
    player.buyVoyageShip(type: type);
    state = player;
    _save();
  }

  VoyageResult? performVoyage({required int index}) {
     Player player = state.copyWith();
    VoyageResult? voyageResult = player.performVoyage(index: index);
    state = player;
    _save();
    return voyageResult;
  }

  void upgradeBuilding({required int index}) {
     Player player = state.copyWith();
    player.upgradeBuilding(buildingIndex: index);
    state = player;
    _save();
  }

  void produceRecource({required ResourceType resourceType}){
    Player player = state.copyWith();
    int tawernLevel = player.buildings.whereType<Tawern>().first.level;
    int generatedAmount = 2 * tawernLevel;
    player.addRecources(recources: {
      resourceType: generatedAmount,
    });
    state = player;
    _save();
  }

  void reRollOffers(){
    Player player = state.copyWith();
    player.reRollOffers();
    state = player;
    _save();
  }

  
  void reRollVoyages(){
    Player player = state.copyWith();
    player.reRollVoyages();
    state = player;
    _save();
  }

  // ================= DEBUG =================
  void reset() {
    state = Player.empty();
    _save();
  }

  // ================= DISPOSE =================
  @override
  void dispose() {
    _tickTimer?.cancel();
    _autoSaveTimer?.cancel();
    super.dispose();
  }
}
