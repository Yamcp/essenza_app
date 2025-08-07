import 'package:flutter/material.dart';
import '/bloc/controllers/daily_phrase_controller.dart';

class DailyQuoteWidget extends StatelessWidget {
  final DailyPhraseController controller;
  const DailyQuoteWidget({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    final phrase = controller.getPhraseForToday();

    return Column(
      children: [
        const Icon(Icons.format_quote, color: Colors.grey, size: 32),
        const SizedBox(height: 8),
        Text(
          phrase.phrase,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 16,
            fontStyle: FontStyle.italic,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 6),
        Text(
          "- ${phrase.author}",
          style: const TextStyle(fontSize: 12, color: Colors.black54),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}