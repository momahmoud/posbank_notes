import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../entities/note.dart';

abstract class NotesRepo {
  Future<Either<Failure, List<Note>>> getAllNotes();
  Future<Either<Failure, Unit>> insertNotes(Note note);
  Future<Either<Failure, Unit>> updateNotes(Note note);
  Future<Either<Failure, Unit>> clearNotes();
}
