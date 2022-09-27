import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:pospank_notes/core/app_strings/success_messages.dart';
import 'package:pospank_notes/features/notes/domain/entities/note.dart';
import 'package:pospank_notes/features/notes/domain/use_cases/clear_notes.dart';
import 'package:pospank_notes/features/notes/domain/use_cases/insert_note.dart';
import 'package:pospank_notes/features/notes/domain/use_cases/update_note.dart';

import '../../../../../core/app_strings/failures_message.dart';
import '../../../../../core/errors/failures.dart';

part 'insert_update_clear_event.dart';
part 'insert_update_clear_state.dart';

class InsertUpdateClearNoteBloc
    extends Bloc<InsertUpdateClearNoteEvent, InsertUpdateClearNoteState> {
  final ClearNotesUseCase clearNotes;
  final InsertNoteUseCase insertNote;
  final UpdateNoteUseCase updateNote;
  InsertUpdateClearNoteBloc({
    required this.clearNotes,
    required this.insertNote,
    required this.updateNote,
  }) : super(InsertUpdateClearInitial()) {
    on<InsertUpdateClearNoteEvent>((event, emit) async {
      if (event is InsertNoteEvent) {
        emit(LoadingAddDeleteUpdateNoteState());
        final failureOrInsertNote = await insertNote(event.note);
        emit(_mapFailureOrInsertUpdateClearNoteState(
          failureOrInsertUpdateClearNote: failureOrInsertNote,
          message: INSERT_SUCCESS_MESSAGE,
        ));
      } else if (event is UpdateNoteEvent) {
        emit(LoadingAddDeleteUpdateNoteState());
        final failureOrUpdateNote = await updateNote(event.note);
        emit(_mapFailureOrInsertUpdateClearNoteState(
          failureOrInsertUpdateClearNote: failureOrUpdateNote,
          message: UPDATE_SUCCESS_MESSAGE,
        ));
      } else if (event is ClearNoteEvent) {
        emit(LoadingAddDeleteUpdateNoteState());
        final failureOrCLearNote = await clearNotes();
        emit(_mapFailureOrInsertUpdateClearNoteState(
          failureOrInsertUpdateClearNote: failureOrCLearNote,
          message: CLEAR_SUCCESS_MESSAGE,
        ));
      }
    });
  }

  InsertUpdateClearNoteState _mapFailureOrInsertUpdateClearNoteState(
      {required Either<Failure, Unit> failureOrInsertUpdateClearNote,
      required String message}) {
    return failureOrInsertUpdateClearNote.fold(
      (failure) =>
          ErrorAddDeleteUpdateNoteState(message: _mapFailureToMessage(failure)),
      (_) => SuccessMessageAddDeleteUpdateNoteState(message: message),
    );
  }

  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return SERVER_FAILURE_MESSAGE;

      case OfflineFailure:
        return OFFLINE_FAILURE_MESSAGE;

      default:
        return "Unexpected Error, Please try again later.";
    }
  }
}
