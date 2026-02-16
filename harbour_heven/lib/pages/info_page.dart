import 'package:flutter/material.dart';

class InfoPage extends StatelessWidget {
  const InfoPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Game Guide"),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            _buildSectionCard(
              theme,
              icon: Icons.anchor,
              title: "What is Harbour Heven?",
              content:
                  "Harbour Heven is a strategic idle game focused on building and managing your own harbour. "
                  "Grow your wealth through smart trading, calculated risks and long-term planning.\n\n"
                  "The game is designed to be played slowly — check in once or twice a day, collect resources, "
                  "send voyages and upgrade your infrastructure.",
            ),

            const SizedBox(height: 16),

            _buildSectionCard(
              theme,
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

            _buildSectionCard(
              theme,
              icon: Icons.sailing,
              title: "Ships & Strategy",
              content:
                  "Ships are your most valuable assets.\n\n"
                  "Different ship types provide different advantages. "
                  "Expanding your fleet increases your potential rewards — "
                  "but also increases the risk of loss.",
            ),

            const SizedBox(height: 16),

            _buildSectionCard(
              theme,
              icon: Icons.factory,
              title: "Production",
              content:
                  "Production buildings generate passive income over time.\n\n"
                  "Upgrade them to improve efficiency and accelerate your harbour’s growth.",
            ),

            const SizedBox(height: 16),

            _buildSectionCard(
              theme,
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

  Widget _buildSectionCard(
    ThemeData theme, {
    required IconData icon,
    required String title,
    required String content,
  }) {
    return Card(
      elevation: 6,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            Row(
              children: [
                Icon(icon, color: theme.colorScheme.primary),
                const SizedBox(width: 8),
                Text(
                  title,
                  style: theme.textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 12),

            Text(
              content,
              style: theme.textTheme.bodyMedium,
            ),
          ],
        ),
      ),
    );
  }
}
