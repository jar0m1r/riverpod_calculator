import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_calculator/models/note.dart';

part 'notes_state.freezed.dart';

@freezed
abstract class NotesState with _$NotesState {
  factory NotesState(List<Note> notes) = Loaded;
  factory NotesState.initial() = Initial;
  factory NotesState.loading() = Loading;
  factory NotesState.error([String message]) = Error;
}
