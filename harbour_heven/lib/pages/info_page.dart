import 'package:flutter/material.dart';
import 'package:harbour_heven/components/build_section_card.dart';

class InfoPage extends StatelessWidget {
  const InfoPage({super.key});

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Game Guide"),
        titleTextStyle: TextStyle(
          color: scheme.onPrimary,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
        iconTheme: IconThemeData(
          color: scheme.onPrimary,
        ),
        backgroundColor: scheme.primary,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            BuildSectionCard(
              icon: Icons.anchor,
              title: "What is Harbour Heven?",
              content:
                  "Harbour Heven is a strategic idle game focused on building and managing your own harbour. "
                  "Grow your wealth through smart trading, calculated risks and long-term planning.\n\n"
                  "The game is designed to be played slowly — check in once or twice a day, collect resources, "
                  "send voyages and upgrade your infrastructure.",
            ),

            const SizedBox(height: 16),

            BuildSectionCard(
              icon: Icons.directions_boat,
              title: "Voyages",
              content:
                  "Voyages are the core feature of the game.\n\n"
                  "Send ships on risky expeditions to earn valuable resources. "
                  "Every voyage carries uncertainty — you might return with profit, "
                  "or lose ships along the way.\n\n"
                  "Smart preparation increases your success chance.",
            ),

            const SizedBox(height: 16),

            BuildSectionCard(
              icon: Icons.sailing,
              title: "Ships & Strategy",
              content:
                  "Ships are your most valuable assets.\n\n"
                  "Different ship types provide different advantages. "
                  "Expanding your fleet increases your potential rewards — "
                  "but also increases the risk of loss.",
            ),

            const SizedBox(height: 16),

            BuildSectionCard(
              icon: Icons.factory,
              title: "Production",
              content:
                  "Production buildings generate passive income over time.\n\n"
                  "Upgrade them to improve efficiency and accelerate your harbour’s growth.",
            ),

            const SizedBox(height: 16),

            BuildSectionCard(
              icon: Icons.info_outline,
              title: "Beta Information",
              content:
                  "Harbour Heven is currently in beta.\n\n"
                  "Balance and systems may change. "
                  "Your feedback helps shape the future of the game.",
            ),
          ],
        ),
      ),
    );
  }
}
