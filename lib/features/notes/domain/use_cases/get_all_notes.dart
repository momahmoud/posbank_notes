import 'package:dartz/dartz.dart';
import 'package:pospank_notes/features/notes/domain/entities/note.dart';
import 'package:pospank_notes/features/notes/domain/repositories/notes_repo.dart';

import '../../../../core/errors/failures.dart';

class GetAllNotesUseCases {
  final NotesRepo notesRepo;

  GetAllNotesUseCases(this.notesRepo);

  Future<Either<Failure, List<Note>>> call() async {
    return await notesRepo.getAllNotes();
  }
}
