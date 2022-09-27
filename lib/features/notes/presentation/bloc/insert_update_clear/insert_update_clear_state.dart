part of 'insert_update_clear_bloc.dart';

abstract class InsertUpdateClearNoteState extends Equatable {
  const InsertUpdateClearNoteState();

  @override
  List<Object> get props => [];
}

class InsertUpdateClearInitial extends InsertUpdateClearNoteState {}

class LoadingAddDeleteUpdateNoteState extends InsertUpdateClearNoteState {}

class SuccessMessageAddDeleteUpdateNoteState
    extends InsertUpdateClearNoteState {
  final String message;

  const SuccessMessageAddDeleteUpdateNoteState({required this.message});

  @override
  List<Object> get props => [message];
}

class ErrorAddDeleteUpdateNoteState extends InsertUpdateClearNoteState {
  final String message;

  const ErrorAddDeleteUpdateNoteState({required this.message});

  @override
  List<Object> get props => [message];
}
