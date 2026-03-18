import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/app_state.dart';

class QuizScreen extends StatefulWidget {
  const QuizScreen({super.key});

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  int currentQuestionIndex = 0;
  int score = 0;
  List<String> weakAreas = [];
  bool quizCompleted = false;

  void _answerQuestion(int selectedIndex, Map<String, dynamic> question) {
    if (selectedIndex == question['correct']) {
      score++;
    } else {
      weakAreas.add(question['question']);
    }

    if (currentQuestionIndex < Provider.of<AppState>(context, listen: false).mockQuizQuestions.length - 1) {
      setState(() {
        currentQuestionIndex++;
      });
    } else {
      setState(() {
        quizCompleted = true;
      });
      Provider.of<AppState>(context, listen: false).updateProgress((score / Provider.of<AppState>(context, listen: false).mockQuizQuestions.length * 100).round(), weakAreas);
    }
  }

  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context);
    final questions = appState.mockQuizQuestions;

    if (quizCompleted) {
      return Scaffold(
        appBar: AppBar(title: const Text('🧠 Quiz Results')),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Score: $score / ${questions.length}', style: const TextStyle(fontSize: 24)),
              const SizedBox(height: 16),
              Text('Weak Areas: ${weakAreas.join(', ')}'),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    currentQuestionIndex = 0;
                    score = 0;
                    weakAreas = [];
                    quizCompleted = false;
                  });
                },
                child: const Text('Retake Quiz'),
              ),
            ],
          ),
        ),
      );
    }

    final currentQuestion = questions[currentQuestionIndex];

    return Scaffold(
      appBar: AppBar(title: const Text('🧠 Quiz')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Text(
              'Question ${currentQuestionIndex + 1} of ${questions.length}',
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 16),
            Text(
              currentQuestion['question'],
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            ...List.generate(
              currentQuestion['options'].length,
              (index) => ElevatedButton(
                onPressed: () => _answerQuestion(index, currentQuestion),
                child: Text(currentQuestion['options'][index]),
              ),
            ),
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