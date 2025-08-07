class Journal {
  int id;
  String text;
  JournalType type;
  bool done;

  Journal({
    required this.id,
    required this.text,
    required this.type,
    this.done = false,
  });
}

enum JournalType { task, note, event }