import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:harbour_heven/data/model/player/player.dart';
import 'package:harbour_heven/data/providers/player/player_provider.dart';
import 'package:harbour_heven/pages/info_page.dart';


class MainGameBar extends ConsumerWidget implements PreferredSizeWidget {
  const MainGameBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final Player player = ref.watch(playerProvider);

    ColorScheme scheme = Theme.of(context).colorScheme;

    return AppBar(
      title: Text("Harbour Heven"),
      titleTextStyle: TextStyle(
        color: scheme.onPrimary,
        fontWeight: FontWeight.bold,
        fontSize: 22.5
      ),
      iconTheme: IconThemeData(
        color: scheme.onPrimary
      ),
      actions: [
        IconButton(
          onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => InfoPage(),)), 
          icon: Icon(Icons.info),
        )
      ],
      bottom: PreferredSize(
        preferredSize: preferredSize, 
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 10),
          child: Wrap(
            spacing: 4,
            children: player.resources.entries.map(
              (r) => Text(
                "${r.key.icon}: ${r.value}/ ${player.calculateCapacity(resourceType: r.key)}  ",
                style: TextStyle(
                  color: scheme.onPrimary,
                  fontSize: 14,
                  fontWeight: FontWeight.bold
                ),
              )
            ).toList(),
          ),
        )
      ),
      backgroundColor: scheme.primary,
    );
  }
  
  @override
  Size get preferredSize => Size(double.infinity, 75);
}
