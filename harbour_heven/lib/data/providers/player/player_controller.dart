import 'dart:async';
import 'dart:math';
import 'package:flutter_riverpod/legacy.dart';
import 'package:harbour_heven/data/hive/player_state.dart';
import 'package:harbour_heven/data/model/building/tawern.dart';
import 'package:harbour_heven/data/model/building/trading_port.dart';
import 'package:harbour_heven/data/model/building/voyage_port.dart';
import 'package:harbour_heven/data/model/enum/building_type.dart';
import 'package:harbour_heven/data/model/enum/resource_type.dart';
import 'package:harbour_heven/data/model/enum/voyage_ship_type.dart';
import 'package:harbour_heven/data/model/player/player.dart';
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
      const Duration(minutes: 1),
      (_) => _save(),
    );
  }

  // ================= TICK =================
  void _onTick() {
    Player player = state.copyWith(resources: Map.from(state.resources));
  
    final now = DateTime.now().millisecondsSinceEpoch;
    player.performCycle(cycles: 1);
 
    if (_getTradingPort(player: player).nextRefreshAt <= now) {
      player.generateOffers();
      _getTradingPort(player: player).nextRefreshAt =
          DateTime.now().add(const Duration(hours: 1)).millisecondsSinceEpoch;
    }

    if (_getVoyagePort(player: player).nextRefreshAt <= now) {
      player.generateVoyages();
      _getVoyagePort(player: player).nextRefreshAt =
          DateTime.now().add(const Duration(hours: 1)).millisecondsSinceEpoch;
    }

    player.lastTickAt = now;
    state = player;
  }

  // ================= OFFLINE =================
  void _applyOfflineProgress() {
    final cycles = _calculateOfflineCycles();
    if (cycles > 0) {
      state.performCycle(cycles: cycles);
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

  // ================= HELPERS =================
  TradingPort _getTradingPort({required Player player}) =>
      player.buildings.firstWhere((b) => b.type == BuildingType.tradingPort)
          as TradingPort;

  VoyagePort _getVoyagePort({required Player player}) =>
      player.buildings.firstWhere((b) => b.type == BuildingType.voyagePort)
          as VoyagePort;

  // ================= ACTIONS =================
  void trade({required int index}) {
    state.trade(index: index);
    _save();
  }

  void haggle({required int index,required int amount}) {
    state.haggle(index: index, amount: amount);
    _save();
  }

  void buyVoyageShip({required VoyageShipType type}) {
    state.buyVoyageShip(type: type);
    _save();
  }

  void performVoyage({required int index}) {
    state.performVoyage(index: index);
    _save();
  }

  void upgradeBuilding({required int index}) {
    state.upgradeBuilding(buildingIndex: index);
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
  }

  void reRollOffers(){
    Player player = state.copyWith();
    player.reRollOffers();
    state = player;
  }

  // ================= DEBUG =================
  void reset() {
    state = Player.empty();
    _save();
  }

  void addTestResources() {
    state.addRecources(
      recources: {
        ResourceType.wood: 10,
        ResourceType.stone: 10,
      },
    );
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
