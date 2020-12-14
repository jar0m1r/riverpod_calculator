import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_calculator/business_logic/notes/notes_state.dart';
import 'package:riverpod_calculator/models/note.dart';
import 'package:riverpod_calculator/services/notes_repository.dart';

class NotesNotifier extends StateNotifier<NotesState> {
  final NotesRepository
      _notesRepository; //notesRepositoryService (check lazySingleton options for a service)

  NotesNotifier(this._notesRepository) : super(NotesInitialState());

  Future<void> getNotes() async {
    try {
      state = NotesLoadingState();
      final notes = await _notesRepository.fetchNotes();
      state = NotesLoadedState(notes);
    } on Exception {
      state = NotesErrorState('error loading notes');
    }
  }

  Future<void> addNote(Note note) async {
    try {
      await _addNoteToRepository(note);
      getNotes();
    } catch (e) {
      state = NotesErrorState(e.toString());
    }
  }

  Future<void> _addNoteToRepository(Note note) async {
    await _notesRepository.createNote(note);
  }
}