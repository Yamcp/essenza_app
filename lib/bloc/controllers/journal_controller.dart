// controllers/journal_controller.dart
import 'package:get/get.dart';
import '/data/models/journal_model.dart';

class JournalController extends GetxController {
  var journals = <Journal>[].obs;

  void addJournal(String text, JournalType type) {
    journals.add(Journal(id: DateTime.now().millisecondsSinceEpoch, text: text, type: type));
  }

  void toggleJournal(int id) {
    final index = journals.indexWhere((b) => b.id == id);
    if (index != -1) {
      journals[index].done = !journals[index].done;
      journals.refresh();
    }
  }

  void removeJournal(int id) {
    journals.removeWhere((b) => b.id == id);
  }
}