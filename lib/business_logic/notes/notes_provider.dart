import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_calculator/business_logic/notes/notes_logic.dart';

final notesViewModelProvider = ChangeNotifierProvider(
    (ref) => NotesViewModel('my notes', ['note1', 'note2']));
