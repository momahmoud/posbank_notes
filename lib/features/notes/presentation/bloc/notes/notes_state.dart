part of 'notes_bloc.dart';

abstract class NotesState extends Equatable {
  const NotesState();

  @override
  List<Object> get props => [];
}

class NotesInitial extends NotesState {}

class LoadingNotesState extends NotesState {}

class LoadedNotesState extends NotesState {
  final List<Note> notes;

  const LoadedNotesState({required this.notes});

  @override
  List<Object> get props => [notes];
}

class ErrorNotesState extends NotesState {
  final String message;

  const ErrorNotesState({required this.message});

  @override
  List<Object> get props => [message];
}
