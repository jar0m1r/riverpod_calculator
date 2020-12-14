import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_calculator/business_logic/notes/notes_state.dart';
import 'package:riverpod_calculator/models/note.dart';
import 'package:riverpod_calculator/services/notes_repository.dart';

class NotesNotifier extends StateNotifier<NotesState> {
  final NotesRepository
      _notesRepository; //notesRepositoryService (check lazySingleton options for a service)
  List<Note> notes;

  NotesNotifier(this._notesRepository) : super(NotesInitialState());

  Future<void> getNotes() async {
    try {
      state = NotesLoadingState();
      final notes = await _notesRepository.fetchNotes();
      state = NotesLoadedState(notes);
    } catch (e) {
      state = NotesErrorState(e);
    }
  }

  Future<void> refresh() async => await getNotes();
}
