import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:essenza_app/data/models/phrase_model.dart'; // Asegúrate de que la ruta sea correcta

class DailyPhraseController extends GetxController {
  final Rx<Phrase?> dailyPhrase = Rx<Phrase?>(null);

  final List<Phrase> phrases = [
    Phrase(text: "La felicidad no es algo hecho. Viene de tus propias acciones.", author: "Dalai Lama"),
    Phrase(text: "El único modo de hacer un gran trabajo es amar lo que haces.", author: "Steve Jobs"),
    Phrase(text: "El futuro pertenece a quienes creen en la belleza de sus sueños.", author: "Eleanor Roosevelt"),
    Phrase(text: "El éxito es la suma de pequeños esfuerzos repetidos día tras día.", author: "Robert Collier"),
    Phrase(text: "Sé tú mismo. Todos los demás ya están ocupados.", author: "Oscar Wilde"),
    Phrase(text: "La vida es lo que pasa mientras estás ocupado haciendo otros planes.", author: "John Lennon"),
    Phrase(text: "No cuentes los días, haz que los días cuenten.", author: "Muhammad Ali"),
    Phrase(text: "La única forma de hacer un gran trabajo es amar lo que haces.", author: "Steve Jobs"),
    Phrase(text: "La vida es un 10% lo que me ocurre y un 90% cómo reacciono a ello.", author: "Charles R. Swindoll"),
    Phrase(text: "Nunca es demasiado tarde para ser quien podrías haber sido.", author: "George Eliot"),
    Phrase(text: "La confianza en ti mismo es la clave para abrir todas las puertas.", author: "Unknown"),
    Phrase(text: "La vida es una especie de bicicleta. Si quieres mantener el equilibrio, pedalea hacia delante.", author: "Unknown"),
    Phrase(text: "Siempre hay algo que agradecer, incluso en los días difíciles.", author: "Unknown"),
    Phrase(text: "Es importante hacer un sueño de la vida y de la realidad de un sueño.", author: "Marie Curie"),
    Phrase(text: "Todo el mundo necesita ser valorado. Todos tenemos el potencial de ofrecer algo.", author: "Lady Di"),
    Phrase(text: "A veces tienes que olvidar lo que sientes y recordar lo que mereces.", author: "Frida Kahlo"),
    Phrase(text: "Si tan solo tienes una sonrisa, entrégasela a alguien a quien ames.", author: "Maya Angelou"),
    Phrase(text: "La única manera de hacer un gran trabajo, es amar lo que haces. Si no lo has encontrado, sigue buscando. No te conformes.", author: "Steve Jobs"),
    Phrase(text: "Aprende a sonreir en cualquier situación. Tómatelo como una oportunidad para expresar tu fortaleza.", author: "Unknown"),
    Phrase(text: "Nunca subestimes el poder que tienes para tomar tu vida en una dirección nueva.", author: "Unknown"),
    Phrase(text: "Persiste, incluso cuando sea difícil.", author: "Unknown"),
    Phrase(text: "Cuida tus pensamientos; se convertirán en tu realidad.", author: "Unknown"),
    Phrase(text: "Sé amable contigo mismo mientras trabajas para ser mejor.", author: "Unknown"),
    Phrase(text: "La vida es un viaje, no un destino. Disfruta del camino.", author: "Ralph Waldo Emerson"),
    Phrase(text: "La gratitud convierte lo que tenemos en suficiente.", author: "Melody Beattie"),
    Phrase(text: "La vida es corta, sonríe mientras aún tengas dientes.", author: "Unknown"),
    Phrase(text: "La felicidad no es algo que pospones para el futuro; es algo que diseñas para el presente.", author: "Jim Rohn"),
    Phrase(text: "La vida es como una cámara. Enfoca en lo bueno, captura los momentos felices, saca de lo negativo un aprendizaje y si las cosas no salen como esperabas, intenta una nueva toma.", author: "Unknown"),
  ];

  @override
  void onInit() {
    super.onInit();
    getDailyPhrase();
  }

  void getDailyPhrase() async {
    final prefs = await SharedPreferences.getInstance();
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final lastPhraseDate = prefs.getString('lastPhraseDate');

    if (lastPhraseDate == null || DateTime.parse(lastPhraseDate) != today) {
      // Es un nuevo día o es la primera vez que se carga
      final randomIndex = today.day % phrases.length;
      dailyPhrase.value = phrases[randomIndex];
      prefs.setString('lastPhraseDate', today.toIso8601String());
      prefs.setInt('lastPhraseIndex', randomIndex);
    } else {
      // El día no ha cambiado, muestra la misma frase
      final lastIndex = prefs.getInt('lastPhraseIndex') ?? 0;
      dailyPhrase.value = phrases[lastIndex];
    }
  }
}