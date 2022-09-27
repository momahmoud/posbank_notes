part of 'insert_update_clear_bloc.dart';

abstract class InsertUpdateClearNoteEvent extends Equatable {
  const InsertUpdateClearNoteEvent();

  @override
  List<Object> get props => [];
}

class InsertNoteEvent extends InsertUpdateClearNoteEvent {
  final Note note;

  const InsertNoteEvent({required this.note});

  @override
  List<Object> get props => [note];
}

class UpdateNoteEvent extends InsertUpdateClearNoteEvent {
  final Note note;

  const UpdateNoteEvent({required this.note});

  @override
  List<Object> get props => [note];
}

class ClearNoteEvent extends InsertUpdateClearNoteEvent {}
