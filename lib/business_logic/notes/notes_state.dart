import 'package:equatable/equatable.dart';
import 'package:flutter/rendering.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_calculator/models/note.dart';

part 'notes_state.freezed.dart';

// abstract class NotesState {}

// class NotesInitialState implements NotesState {}

// class NotesLoadingState implements NotesState {}

// class NotesLoadedState extends Equatable implements NotesState {
//   final List<Note> notes;

//   NotesLoadedState(this.notes);

//   @override
//   List<Object> get props => [notes];
// }

// class NotesErrorState extends Equatable implements NotesState {
//   final String message;

//   NotesErrorState(this.message);

//   @override
//   List<Object> get props => [message];
// }

// class LoadingState {}

// class LoadedState {
//   final List<Note> notes;

//   LoadedState(this.notes);
// }

// class InitialState {}

// class ErrorState {
//   final String message;

//   ErrorState(this.message);
// }

@freezed
abstract class NotesState with _$NotesState {
  factory NotesState(List<Note> notes) = Loaded;
  factory NotesState.initial() = Initial;
  factory NotesState.loading() = Loading;
  factory NotesState.error([String message]) = Error;
}
