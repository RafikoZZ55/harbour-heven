import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:harbour_heven/views/town_generators_view.dart';
import 'package:harbour_heven/views/town_special_view.dart';

class TownView extends ConsumerStatefulWidget {
  const TownView({super.key});

  @override
  ConsumerState<TownView> createState() => _TownViewState();
}

enum TownViews {special, generators}

class _TownViewState extends ConsumerState<TownView> {

  TownViews? _selectedTownViewBtn;
  Widget? _selectedTownView;

  @override
  Widget build(BuildContext context) {
    _selectedTownViewBtn ??= TownViews.special;
    if(_selectedTownViewBtn == TownViews.special) {_selectedTownView = TownSpecialView();}
    else {_selectedTownView = TownGeneratorsView();}

    return Padding(
      padding: const EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Town',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  width: 250,
                  child: SegmentedButton(
                    segments: [
                      ButtonSegment(
                        value: TownViews.special,
                        label: Text("Special"),
                      ),
                      ButtonSegment(
                        value: TownViews.generators,
                        label: Text("Generators"),
                      ),
                    ], 
                    selected: {_selectedTownViewBtn},
                    onSelectionChanged: (selected) {
                      setState(() {
                        _selectedTownViewBtn = selected.first;
                      });
                    },
                  ),
                )
              ],
            ),

            Expanded(
              child: AnimatedSwitcher(
                duration: Duration(microseconds: 250),
                child: _selectedTownView,
              ),
            ),

          ],
        ),
    );
  }
}
