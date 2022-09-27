part of 'notes_bloc.dart';

abstract class NotesEvent extends Equatable {
  const NotesEvent();

  @override
  List<Object> get props => [];
}

class GetAllNotesEvent extends NotesEvent {}

class RefreshNotesEvent extends NotesEvent {}
