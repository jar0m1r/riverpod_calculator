import 'package:riverpod_calculator/domain/models/note.dart';

abstract class NotesRepository {
  List<Note> notes;
  Future<List<Note>> fetchNotes();
  Future<void> createNote(Note note);
}

class FakeNotesRepository extends NotesRepository {
  List<Note> notes;

  Future<List<Note>> fetchNotes() async {
    if (notes == null) {
      await Future.delayed(Duration(seconds: 1));
      notes = [];
      notes.addAll([
        Note('my first note',
            'This is a very very imoortant moment. The first note ever written. We shall always remember. Peace!'),
        Note('my second note',
            'It\'s starting to wear off. This is not as exciting as I thoughtn it would be. I\'m very very disapointed.'),
      ]);
      return notes;
    } else {
      await Future.delayed(Duration(milliseconds: 300));
      return notes;
    }
  }

  Future<void> createNote(Note note) async {
    Future.delayed(Duration(seconds: 1));
    notes.add(note);
  }
}
