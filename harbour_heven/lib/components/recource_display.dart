
import 'package:flutter/material.dart';
import 'package:harbour_heven/data/model/enum/recource_type.dart';

class RecourceDisplay extends StatelessWidget {
  const RecourceDisplay({ 
    super.key, 
    required this.recourceType, 
    required this.amount 
  });
  final RecourceType recourceType;
  final int amount;

  @override
  Widget build(BuildContext context){
    final ColorScheme sheme = Theme.of(context).colorScheme;

    return Padding(
      padding: const EdgeInsets.all(2.5),
      child: Container(
        decoration: BoxDecoration(
          color: sheme.primaryContainer,
          borderRadius: BorderRadius.all(Radius.elliptical(5, 5))
        ),
        child: Padding(
          padding: const EdgeInsets.all(2.0),
          child: Text(
            "${recourceType.name}: $amount",
            style: TextStyle(
              color: sheme.onPrimaryContainer,
              fontSize: 15
            ),
            ),
        ),
      ),
    );
  }
}