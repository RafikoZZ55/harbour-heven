import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/adapters.dart';
void main() async {
  Hive.initFlutter();

  runApp(ProviderScope(child: const Main()));
}

class Main extends StatefulWidget {
  const Main({ Key? key }) : super(key: key);

  @override
  _MainState createState() => _MainState();
}

class _MainState extends State<Main> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(

    );
  }
}