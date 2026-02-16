import 'package:flutter/material.dart';

class BuildSectionCard extends StatelessWidget {
const BuildSectionCard({ super.key, required this.icon , required this.title, required this.content });
  final IconData icon;
  final String title;
  final String content;

  @override
  Widget build(BuildContext context){
    final ColorScheme scheme = Theme.of(context).colorScheme;


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
                Icon(icon, color: scheme.primary),
                const SizedBox(width: 8),
                Text(
                  title,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20
                  ),
                ),
              ],
            ),

            const SizedBox(height: 12),

            Text(
              content,
              style: TextStyle(
                fontSize: 15
              ),
            ),
          ],
        ),
      ),
    );
  }
}