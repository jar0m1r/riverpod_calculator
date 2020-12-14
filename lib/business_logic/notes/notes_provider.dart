import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_calculator/business_logic/notes/notes_notifier.dart';
import 'package:riverpod_calculator/services/notes_repository.dart';

final notesRepositoryProvider =
    Provider<NotesRepository>((ref) => FakeNotesRepository());

final notesNotifierProvider = StateNotifierProvider<NotesNotifier>((ref) {
  final repositoryProvider = ref.watch(notesRepositoryProvider);
  final notesNotifier = NotesNotifier(repositoryProvider);
  notesNotifier.getNotes();
  return notesNotifier;
});
