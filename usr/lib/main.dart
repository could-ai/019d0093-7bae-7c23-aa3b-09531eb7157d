import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'screens/home_screen.dart';
import 'screens/chat_screen.dart';
import 'screens/drug_library_screen.dart';
import 'screens/quiz_screen.dart';
import 'screens/flashcards_screen.dart';
import 'screens/notes_scanner_screen.dart';
import 'screens/progress_dashboard_screen.dart';
import 'screens/compare_screen.dart';
import 'providers/app_state.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AppState()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MedPharm AI',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const HomeScreen(),
        '/chat': (context) => const ChatScreen(),
        '/drugs': (context) => const DrugLibraryScreen(),
        '/quiz': (context) => const QuizScreen(),
        '/flashcards': (context) => const FlashcardsScreen(),
        '/scanner': (context) => const NotesScannerScreen(),
        '/progress': (context) => const ProgressDashboardScreen(),
        '/compare': (context) => const CompareScreen(),
      },
    );
  }
}