import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/app_state.dart';

class ProgressDashboardScreen extends StatelessWidget {
  const ProgressDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final progress = Provider.of<AppState>(context).progressData;

    return Scaffold(
      appBar: AppBar(title: const Text('📊 Progress Dashboard')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Topics Completed: ${progress['topicsCompleted']} / ${progress['totalTopics']}', style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 16),
            Text('Recent Quiz Scores: ${progress['quizScores'].join(', ')}', style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 16),
            Text('Weak Areas: ${progress['weakAreas'].join(', ')}', style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 16),
            const Text('Study Streak: 5 days (mock)', style: TextStyle(fontSize: 18)),
            const Spacer(),
            const Text(
              '⚠️ For Educational Purposes Only — Not Medical Advice',
              style: TextStyle(fontSize: 12, color: Colors.grey),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}