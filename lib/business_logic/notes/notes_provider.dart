import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_calculator/business_logic/notes/notes_notifier.dart';
import 'package:riverpod_calculator/services/notes_repository.dart';

final notesRepositoryProvider =
    Provider<NotesRepository>((ref) => FakeNotesRepository());

final notesNotifierProvider = StateNotifierProvider(
    (ref) => NotesNotifier(ref.watch(notesRepositoryProvider)));
