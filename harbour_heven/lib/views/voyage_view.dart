import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:harbour_heven/data/providers/player/player_controller.dart';
import 'package:harbour_heven/data/providers/player/player_provider.dart';
import 'package:harbour_heven/views/voyage_ships_view.dart';
import 'package:harbour_heven/views/voyage_voyage_view.dart';

class VoyageView extends ConsumerStatefulWidget {
  const VoyageView({ super.key });

  @override
  createState() => _VoyageViewState();
}

enum SelectionButtons { ships, voyages}

class _VoyageViewState extends ConsumerState<VoyageView> {
  SelectionButtons? _selectedButton;
  Widget? _selectedWiget;

  @override
  Widget build(BuildContext context) {

    PlayerController playerController = ref.read(playerProvider.notifier);

    _selectedButton ??= SelectionButtons.voyages;
    if(_selectedButton == SelectionButtons.ships){
      _selectedWiget = VoyageShipsView();
    }
    else if(_selectedButton == SelectionButtons.voyages){
      _selectedWiget = VoyageVoyageView();
    }

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
             
              FilledButton(onPressed: () => playerController.reRollVoyages(), child: Text("Re-roll 🪙: -5")),

              SizedBox(
                width: 225,
                child: SegmentedButton<SelectionButtons>(
                segments: [
                  ButtonSegment(
                    value: SelectionButtons.ships,
                    label: Text("Ships")
                  ),
                  ButtonSegment(
                    value: SelectionButtons.voyages,
                    label: Text("Voyages")
                  ),
                ], 
                selected: {_selectedButton!},
                onSelectionChanged: ( Set<SelectionButtons> s) {
                  setState(() {
                    _selectedButton = s.first;
                    if(_selectedButton == SelectionButtons.ships){
                      _selectedWiget = VoyageShipsView();
                    }
                    else if(_selectedButton == SelectionButtons.voyages){
                      _selectedWiget = VoyageVoyageView();
                    }
                  });
                },
              ),
              )
            ],
          ),

          const SizedBox(height: 12),

          Expanded(
            child: AnimatedSwitcher(
              duration:  Duration(milliseconds: 250),
              child: _selectedWiget,
              
            )
          ),
        ],
      ),
    );

  }
}