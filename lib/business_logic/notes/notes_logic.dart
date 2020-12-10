import 'package:flutter/foundation.dart';

class NotesViewModel extends ChangeNotifier {
  String name;
  List<String> notes;

  changeName(String name) {
    this.name = name;
    notifyListeners();
  }

  addNote() {
    notes.add('note ${notes.length + 1}');
    notifyListeners();
  }

  NotesViewModel(this.name, this.notes);
}
