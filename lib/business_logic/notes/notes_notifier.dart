import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_calculator/business_logic/notes/notes_state.dart';
import 'package:riverpod_calculator/models/note.dart';
import 'package:riverpod_calculator/services/notes_repository.dart';

class NotesNotifier extends StateNotifier<NotesState> {
  final NotesRepository
      _notesRepository; //notesRepositoryService (check lazySingleton options for a service)

  NotesNotifier(this._notesRepository) : super(NotesState.initial());

  Future<void> getNotes() async {
    try {
      state = NotesState.loading();
      final notes = await _notesRepository.fetchNotes();
      state = NotesState(notes);
    } on Exception {
      state = NotesState.error('error loading notes');
    }
  }

  Future<void> addNote(Note note) async {
    try {
      await _addNoteToRepository(note);
      getNotes(); //this is using a state notifier as a viewmodel, should be one or the other
    } catch (e) {
      state = NotesState.error(e.toString());
    }
  }

  Future<void> _addNoteToRepository(Note note) async {
    await _notesRepository.createNote(note);
  }
}
