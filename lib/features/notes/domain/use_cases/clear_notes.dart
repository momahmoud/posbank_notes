import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../repositories/notes_repo.dart';

class ClearNotesUseCase {
  final NotesRepo notesRepo;

  ClearNotesUseCase(this.notesRepo);

  Future<Either<Failure, Unit>> call() async {
    return await notesRepo.clearNotes();
  }
}
