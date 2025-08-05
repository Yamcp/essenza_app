import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:essenza_app/bloc/controllers/daily_phrase_controller.dart'; // Asegúrate de que la ruta sea correcta

class DailyPhraseView extends StatelessWidget {
  DailyPhraseView({super.key});

  final DailyPhraseController controller = Get.put(DailyPhraseController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Frase del Día'),
        backgroundColor: Color(0xFFB794F6),
        elevation: 0,
        foregroundColor: Colors.white,
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF9F7AEA), // Morado muy claro
              Color(0xFFF5E6FF), // Rosa muy claro
            ],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Obx(() {
            final phrase = controller.dailyPhrase.value;
            if (phrase == null) {
              return const CircularProgressIndicator();
            }
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '"${phrase.text}"',
                  style: const TextStyle(
                    fontSize: 24,
                    fontStyle: FontStyle.italic,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16),
                Text(
                  '- ${phrase.author}',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            );
          }),
        ),
      ),
    );
  }
}