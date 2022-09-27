import 'package:dartz/dartz.dart';
import 'package:pospank_notes/features/notes/domain/entities/note.dart';
import 'package:pospank_notes/features/notes/domain/repositories/notes_repo.dart';

import '../../../../core/errors/failures.dart';

class UpdateNoteUseCase {
  final NotesRepo notesRepo;

  UpdateNoteUseCase(this.notesRepo);

  Future<Either<Failure, Unit>> call(Note note) async {
    return await notesRepo.updateNotes(note);
  }
}
