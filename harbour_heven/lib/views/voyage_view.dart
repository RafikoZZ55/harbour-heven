import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:harbour_heven/data/model/building/voyage_port.dart';
import 'package:harbour_heven/data/providers/player/player_provider.dart';
import 'package:harbour_heven/views/voyage_ships_view.dart';
import 'package:harbour_heven/views/voyage_voyage_view.dart';

class VoyageView extends ConsumerStatefulWidget {
  const VoyageView({super.key});

  @override
  createState() => _VoyageViewState();
}

enum SelectionButtons { ships, voyages }

class _VoyageViewState extends ConsumerState<VoyageView> {
  SelectionButtons? _selectedButton;
  Widget? _selectedWidget;
  Timer? _timer;
  String _formattedTime = "";

  @override
  void initState() {
    super.initState();

    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      final voyagePort = ref.read(playerProvider).buildings
          .whereType<VoyagePort>()
          .first;

      final nextRefreshAt = voyagePort.nextRefreshAt;
      final now = DateTime.now().millisecondsSinceEpoch;
      final remainingMs = max(0, nextRefreshAt - now);

      final hours = remainingMs ~/ (1000 * 60 * 60);
      final minutes = (remainingMs ~/ (1000 * 60)) % 60;
      final seconds = (remainingMs ~/ 1000) % 60;
  
      setState(() {
        _formattedTime = "${hours}h ${minutes}m ${seconds}s";
      });
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final playerController = ref.read(playerProvider.notifier);
    final ColorScheme scheme = Theme.of(context).colorScheme;
    _selectedButton ??= SelectionButtons.voyages;
    _selectedWidget ??= _selectedButton == SelectionButtons.ships
        ? const VoyageShipsView()
        : const VoyageVoyageView();

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              FilledButton(
                onPressed: () => playerController.reRollVoyages(),
                child: const Text("Re-roll 🪙: -5"),
              ),

              SizedBox(
                width: 225,
                child: SegmentedButton<SelectionButtons>(
                  segments: const [
                    ButtonSegment(
                        value: SelectionButtons.ships, label: Text("Ships")),
                    ButtonSegment(
                        value: SelectionButtons.voyages,
                        label: Text("Voyages")),
                  ],
                  selected: {_selectedButton!},
                  onSelectionChanged: (s) {
                    setState(() {
                      _selectedButton = s.first;
                      _selectedWidget = _selectedButton == SelectionButtons.ships
                          ? const VoyageShipsView()
                          : const VoyageVoyageView();
                    });
                  },
                ),
              ),
            ],
          ),

          const SizedBox(height: 8),
          SizedBox(
            width: double.infinity,
            child: Text(
              "  Next refresh: $_formattedTime",
              textAlign: TextAlign.start,
              style: TextStyle(
                fontSize: 12.5,
                color: scheme.primary,
                fontWeight: FontWeight.bold
              ),
              ),
          ),
          const SizedBox(height: 12),

          Expanded(
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 500),
              child: _selectedWidget,
            ),
          ),
        ],
      ),
    );
  }
}
