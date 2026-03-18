import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/app_state.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('🏥 MedPharm AI'),
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Theme.of(context).colorScheme.onPrimary,
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            color: Theme.of(context).colorScheme.primaryContainer,
            child: const Column(
              children: [
                Text(
                  'Your Personal Pharmacology Professor',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 8),
                Text(
                  'Welcome! What would you like to study today?',
                  style: TextStyle(fontSize: 16),
                ),
              ],
            ),n          ),
          Expanded(
            child: GridView.count(
              crossAxisCount: 2,
              padding: const EdgeInsets.all(16),
              children: [
                _buildModuleCard(context, '🤖 AI Professor', '/chat'),
                _buildModuleCard(context, '💊 Drug Library', '/drugs'),
                _buildModuleCard(context, '🧠 Quiz', '/quiz'),
                _buildModuleCard(context, '🃏 Flashcards', '/flashcards'),
                _buildModuleCard(context, '📷 Scan Notes', '/scanner'),
                _buildModuleCard(context, '📊 Progress', '/progress'),
                _buildModuleCard(context, '⚖️ Compare Drugs', '/compare'),
              ],
            ),
          ),
          const Padding(
            padding: EdgeInsets.all(16),
            child: Text(
              '⚠️ For Educational Purposes Only — Not Medical Advice',
              style: TextStyle(fontSize: 12, color: Colors.grey),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildModuleCard(BuildContext context, String title, String route) {
    return Card(
      margin: const EdgeInsets.all(8),
      child: InkWell(
        onTap: () => Navigator.pushNamed(context, route),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Text(
              title,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    );
  }
}