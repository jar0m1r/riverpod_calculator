import 'package:equatable/equatable.dart';
import 'package:flutter_riverpod/all.dart';

class Note extends Equatable {
  final String title;
  final String body;

  Note(this.title, this.body);

  @override
  List<Object> get props => [title, body];
}
