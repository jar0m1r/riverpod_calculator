import 'package:equatable/equatable.dart';
import 'package:riverpod_calculator/models/note.dart';

abstract class NotesState {}

class NotesInitialState implements NotesState {}

class NotesLoadingState implements NotesState {}

class NotesLoadedState extends Equatable implements NotesState {
  final List<Note> notes;

  NotesLoadedState(this.notes);

  @override
  List<Object> get props => [notes];
}

class NotesErrorState extends Equatable implements NotesState {
  final String message;

  NotesErrorState(this.message);

  @override
  List<Object> get props => [message];
}
