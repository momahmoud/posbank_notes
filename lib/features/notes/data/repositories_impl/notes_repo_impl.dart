import 'package:pospank_notes/core/errors/exceptions.dart';
import 'package:pospank_notes/features/notes/data/models/note_model.dart';
import 'package:pospank_notes/features/notes/domain/entities/note.dart';
import 'package:pospank_notes/core/errors/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:pospank_notes/features/notes/domain/repositories/notes_repo.dart';

import '../../../../core/network/network_info.dart';
import '../data_sources/local_data_source.dart';
import '../data_sources/remote_data_source.dart';

typedef ClearOrUpdateOrInsertNote = Future<Unit> Function();

class NotesRepoImpl implements NotesRepo {
  final RemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;
  final LocalDataSource localDataSource;

  NotesRepoImpl({
    required this.remoteDataSource,
    required this.networkInfo,
    required this.localDataSource,
  });

  @override
  Future<Either<Failure, List<Note>>> getAllNotes() async {
    if (await networkInfo.isConnected) {
      try {
        final remoteNotes = await remoteDataSource.getAllNotes();
        localDataSource.cachedNotes(remoteNotes);
        return Right(remoteNotes);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      try {
        final localPosts = await localDataSource.getCachedNotes();
        return Right(localPosts);
      } on DatabaseCacheException {
        return Left(DatabaseCacheFailure());
      }
    }
  }

  @override
  Future<Either<Failure, Unit>> insertNotes(Note note) async {
    final NoteModel noteModel = NoteModel(
      placeDateTime: note.placeDateTime,
      text: note.text,
    );
    if (await networkInfo.isConnected) {
      return _getMessage(() {
        return remoteDataSource.insertNotes(noteModel);
      });
    } else {
      return _getMessage(() {
        return localDataSource.insertNotes(noteModel);
      });
    }
  }

  @override
  Future<Either<Failure, Unit>> updateNotes(Note note) async {
    final NoteModel noteModel = NoteModel(
      id: note.id,
      placeDateTime: note.placeDateTime,
      text: note.text,
      userId: note.userId,
    );
    if (await networkInfo.isConnected) {
      return _getMessage(() {
        return remoteDataSource.updateNotes(noteModel);
      });
    } else {
      return _getMessage(() {
        return localDataSource.updateNotes(noteModel);
      });
    }
  }

  @override
  Future<Either<Failure, Unit>> clearNotes() async {
    if (await networkInfo.isConnected) {
      return _getMessage(() {
        return remoteDataSource.clearNotes();
      });
    } else {
      return _getMessage(() {
        return localDataSource.clearNotes();
      });
    }
  }

  Future<Either<Failure, Unit>> _getMessage(
      ClearOrUpdateOrInsertNote clearOrUpdateOrInsertNote) async {
    try {
      await clearOrUpdateOrInsertNote();
      return const Right(unit);
    } on ServerException {
      return Left(ServerFailure());
    }
  }
}
