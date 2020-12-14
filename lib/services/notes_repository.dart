import 'package:riverpod_calculator/models/note.dart';

abstract class NotesRepository {
  Future<List<Note>> fetchNotes();
}

class FakeNotesRepository implements NotesRepository {
  Future<List<Note>> fetchNotes() async {
    await Future.delayed(Duration(seconds: 1));
    return [
      Note('my first note',
          'This is a very very imoortant moment. The first note ever written. We shall always remember. Peace!'),
      Note('my second note',
          'It\'s starting to wear off. This is not as exciting as I thoughtn it would be. I\'m very very disapointed.'),
    ];
  }
}
