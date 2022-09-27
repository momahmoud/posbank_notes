import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:pospank_notes/features/notes/domain/entities/note.dart';

import '../../../../../core/app_strings/failures_message.dart';
import '../../../../../core/errors/failures.dart';
import '../../../domain/use_cases/get_all_notes.dart';

part 'notes_event.dart';
part 'notes_state.dart';

class NotesBloc extends Bloc<NotesEvent, NotesState> {
  final GetAllNotesUseCases getAllNotes;
  NotesBloc({
    required this.getAllNotes,
  }) : super(NotesInitial()) {
    on<NotesEvent>((event, emit) async {
      if (event is GetAllNotesEvent) {
        emit(LoadingNotesState());
        final failureOrNotes = await getAllNotes();
        emit(_mapFailureOrNotesToState(failureOrNotes));
      } else if (event is RefreshNotesEvent) {
        emit(LoadingNotesState());
        final failureOrNotes = await getAllNotes();
        emit(_mapFailureOrNotesToState(failureOrNotes));
      }
    });
  }

  NotesState _mapFailureOrNotesToState(
      Either<Failure, List<Note>> failureOrNotes) {
    return failureOrNotes.fold(
      (failure) => ErrorNotesState(message: _mapFailureToMessage(failure)),
      (notes) => LoadedNotesState(notes: notes),
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
