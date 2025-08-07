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
        backgroundColor: Color(0xFF9F7A7A),
        elevation: 0,
        foregroundColor: Colors.white,
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFFEBDBD2),
              Color(0xFFF0E9E4),
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
      bottomNavigationBar: NavigationBar(
        backgroundColor: Color(0xFF9F7A7A),
        indicatorColor: Color(0xFFE5DFD9),
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home, color: Color(0xFF1E1F21)),
            label: 'Inicio',
          ),
          NavigationDestination(
            icon: Icon(Icons.bookmark, color: Color(0xFF1E1F21)),
            label: 'Frases',
          ),
          NavigationDestination(
            icon: Icon(Icons.book, color: Color(0xFF1E1F21)),
            label: 'Journal',
          ),
          NavigationDestination(
            icon: Icon(Icons.settings, color: Color(0xFF1E1F21)),
            label: 'Ajustes',
          ),
        ],
      ),
    );
  }
}