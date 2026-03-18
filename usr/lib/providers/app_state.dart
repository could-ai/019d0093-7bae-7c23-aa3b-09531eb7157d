import 'package:flutter/foundation.dart';

class AppState extends ChangeNotifier {
  // Mock chat history for AI professor (to be replaced with Supabase Edge Function)
  List<Map<String, String>> chatHistory = [];

  // Mock quiz data
  List<Map<String, dynamic>> mockQuizQuestions = [
    {
      'question': 'What class does Omeprazole belong to?',
      'options': ['H2 Blocker', 'Proton Pump Inhibitor', 'Antacid', 'Antibiotic'],
      'correct': 1,
      'explanation': 'Omeprazole is a Proton Pump Inhibitor (PPI), the most powerful acid suppression drug class.'
    },
    {
      'question': 'Why should Sucralfate NOT be given with PPIs simultaneously?',
      'options': ['It causes diarrhea', 'It needs acidic pH to work', 'It interacts with food', 'It is too expensive'],
      'correct': 1,
      'explanation': 'Sucralfate polymerizes in acidic pH to form a protective gel. PPIs suppress acid, preventing Sucralfate from working.'
    },
  ];

  // Mock flashcard data
  List<Map<String, String>> mockFlashcards = [
    {'front': 'What is the mechanism of Omeprazole?', 'back': 'Irreversibly inhibits H+/K+ ATPase (Proton Pump) in parietal cells, blocking acid secretion almost completely.'},
    {'front': 'What class is Famotidine?', 'back': 'H2 Histamine Receptor Blocker - competitively blocks H2 receptors to reduce acid secretion by 70%.'},
  ];

  // Mock progress data
  Map<String, dynamic> progressData = {
    'topicsCompleted': 3,
    'totalTopics': 8,
    'quizScores': [80, 90, 75],
    'weakAreas': ['Drug interactions', 'Pharmacokinetics'],
  };

  void addChatMessage(String message, String sender) {
    chatHistory.add({'message': message, 'sender': sender});
    notifyListeners();
  }

  // TODO: Replace with Supabase Edge Function for real AI responses
  String getMockAIResponse(String userMessage) {
    if (userMessage.toLowerCase().contains('omeprazole')) {
      return 'Omeprazole is a Proton Pump Inhibitor (PPI). It\'s a prodrug that irreversibly inhibits H+/K+ ATPase in parietal cells, suppressing acid by 90-95%. Always taken before meals. Key exam fact: First PPI developed! 💡 This information is for educational purposes only. Always consult a qualified healthcare professional for medical decisions.';
    }
    return 'As your AI Professor, I\'m here to help with pharmacology! Ask me about any drug mechanism, body pathway, or clinical use. 💡 This information is for educational purposes only. Always consult a qualified healthcare professional for medical decisions.';
  }

  void updateProgress(int score, List<String> weakAreas) {
    progressData['quizScores'].add(score);
    progressData['weakAreas'] = weakAreas;
    notifyListeners();
  }
}