import 'package:flutter/material.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';
import 'package:provider/provider.dart';
import '../providers/app_state.dart';

class FlashcardsScreen extends StatefulWidget {
  const FlashcardsScreen({super.key});

  @override
  State<FlashcardsScreen> createState() => _FlashcardsScreenState();
}

class _FlashcardsScreenState extends State<FlashcardsScreen> {
  final CardSwiperController controller = CardSwiperController();
  bool showBack = false;
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final flashcards = Provider.of<AppState>(context).mockFlashcards;

    return Scaffold(
      appBar: AppBar(title: const Text('🃏 Flashcards')),
      body: Column(
        children: [
          Expanded(
            child: CardSwiper(
              controller: controller,
              cardsCount: flashcards.length,
              onSwipe: _onSwipe,
              cardBuilder: (context, index, percentThresholdX, percentThresholdY) {
                return _buildFlashcard(flashcards[index]);
              },
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () => controller.swipe(CardSwiperDirection.left),
                child: const Text('❌ Review Again'),
              ),
              const SizedBox(width: 16),
              ElevatedButton(
                onPressed: () => controller.swipe(CardSwiperDirection.right),
                child: const Text('✅ Know It'),
              ),
            ],
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

  Widget _buildFlashcard(Map<String, String> card) {
    return Card(
      margin: const EdgeInsets.all(32),
      child: InkWell(
        onTap: () => setState(() => showBack = !showBack),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(32),
            child: Text(
              showBack ? card['back']! : card['front']!,
              style: const TextStyle(fontSize: 18),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    );
  }

  bool _onSwipe(
    int previousIndex,
    int? currentIndex,
    CardSwiperDirection direction,
  ) {
    setState(() {
      showBack = false;
      this.currentIndex = currentIndex ?? 0;
    });
    // TODO: Implement spaced repetition logic once Supabase is connected
    return true;
  }
}