// views/journal_view.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '/bloc/controllers/journal_controller.dart';
import '/data/models/journal_model.dart';

class JournalView extends StatelessWidget {
  JournalView({Key? key}) : super(key: key);

  final JournalController journalController = Get.put(JournalController());
  final TextEditingController textController = TextEditingController();
  JournalType selectedType = JournalType.task;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF3ECE7),
      appBar: AppBar(
        title: const Text('Journal'),
        backgroundColor: const Color(0xFF9F7A7A),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Input de nuevo bullet
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: textController,
                    decoration: const InputDecoration(
                      hintText: "Escribe una nueva tarea, nota o evento...",
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                DropdownButton<JournalType>(
                  value: selectedType,
                  icon: const Icon(Icons.arrow_downward),
                  items: [
                    DropdownMenuItem(
                      value: JournalType.task,
                      child: Row(children: const [Icon(Icons.check_box_outline_blank, size: 18), SizedBox(width: 4), Text('Tarea')]),
                    ),
                    DropdownMenuItem(
                      value: JournalType.note,
                      child: Row(children: const [Icon(Icons.comment, size: 18), SizedBox(width: 4), Text('Nota')]),
                    ),
                    DropdownMenuItem(
                      value: JournalType.event,
                      child: Row(children: const [Icon(Icons.event, size: 18), SizedBox(width: 4), Text('Evento')]),
                    ),
                  ],
                  onChanged: (value) {
                    if (value != null) {
                      selectedType = value;
                    }
                  },
                ),
                const SizedBox(width: 8),
                FloatingActionButton(
                  heroTag: null,
                  backgroundColor: const Color(0xFF9F7A7A),
                  onPressed: () {
                    if (textController.text.trim().isNotEmpty) {
                      journalController.addJournal(textController.text.trim(), selectedType);
                      textController.clear();
                    }
                  },
                  child: const Icon(Icons.add),
                  mini: true,
                ),
              ],
            ),
            const SizedBox(height: 20),
            // Lista de bullets
            Expanded(
              child: Obx(() {
                final journals = journalController.journals;
                if (journals.isEmpty) {
                  return Center(
                      child: Text("¡No hay journals para hoy!",
                          style: TextStyle(color: Colors.grey[600])));
                }
                return ListView.builder(
                  itemCount: journals.length,
                  itemBuilder: (context, index) {
                    final journal = journals[index];
                    return Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14)),
                      margin: const EdgeInsets.symmetric(vertical: 6),
                      child: ListTile(
                        leading: Icon(
                          _iconForType(journal.type, journal.done),
                          color: journal.done
                              ? Colors.green
                              : _colorForType(journal.type),
                        ),
                        title: Text(
                          journal.text,
                          style: journal.done
                              ? const TextStyle(
                                  decoration: TextDecoration.lineThrough,
                                  color: Colors.grey)
                              : const TextStyle(),
                        ),
                        trailing: IconButton(
                          icon: const Icon(Icons.delete_outline, color: Colors.redAccent),
                          onPressed: () => journalController.removeJournal(journal.id),
                        ),
                        onTap: () => journalController.toggleJournal(journal.id),
                      ),
                    );
                  },
                );
              }),
            ),
          ],
        ),
      ),
    );
  }

  IconData _iconForType(JournalType type, bool done) {
    switch (type) {
      case JournalType.task:
        return done ? Icons.check_box : Icons.check_box_outline_blank;
      case JournalType.note:
        return Icons.comment;
      case JournalType.event:
        return Icons.event;
      default:
        return Icons.radio_button_unchecked;
    }
  }

  Color _colorForType(JournalType type) {
    switch (type) {
      case JournalType.task:
        return Colors.orange;
      case JournalType.note:
        return Colors.blueAccent;
      case JournalType.event:
        return Colors.purple;
      default:
        return Colors.grey;
    }
  }
}