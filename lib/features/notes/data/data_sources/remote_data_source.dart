import 'package:dartz/dartz.dart';

import 'package:pospank_notes/core/errors/exceptions.dart';
import 'package:pospank_notes/features/notes/data/models/note_model.dart';
import 'package:dio/dio.dart';

abstract class RemoteDataSource {
  Future<List<NoteModel>> getAllNotes();
  Future<Unit> clearNotes();
  Future<Unit> updateNotes(NoteModel noteModel);
  Future<Unit> insertNotes(NoteModel noteModel);
}

class RemoteDataSourceImpl implements RemoteDataSource {
  final Dio dio;

  RemoteDataSourceImpl({required this.dio});
  @override
  Future<List<NoteModel>> getAllNotes() async {
    final response =
        await dio.get('https://noteapi.popssolutions.net/notes/getall');
    if (response.statusCode == 200) {
      final List jsonData = response.data as List;
      final List<NoteModel> notesModel = jsonData
          .map<NoteModel>((jsonPostModel) => NoteModel.fromJson(jsonPostModel))
          .toList();

      return notesModel;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<Unit> insertNotes(NoteModel noteModel) async {
    final body = {
      'text': noteModel.text,
      'userId': noteModel.userId,
      'placeDateTime': noteModel.placeDateTime,
    };

    final response = await dio.post(
      'https://noteapi.popssolutions.net/notes/insert',
      data: body,
    );
    if (response.statusCode == 200) {
      return Future.value(unit);
    } else {
      throw ServerException();
    }
  }

  @override
  Future<Unit> updateNotes(NoteModel noteModel) async {
    final body = {
      'id': noteModel.id,
      'text': noteModel.text,
      'userId': noteModel.userId,
      'placeDateTime': noteModel.placeDateTime,
    };

    final response = await dio.post(
      'https://noteapi.popssolutions.net/notes/update',
      data: body,
    );
    if (response.statusCode == 200) {
      return Future.value(unit);
    } else {
      throw ServerException();
    }
  }

  @override
  Future<Unit> clearNotes() async {
    final response = await dio.post(
      'https://noteapi.popssolutions.net/notes/clear',
    );
    if (response.statusCode == 200) {
      return Future.value(unit);
    } else {
      throw ServerException();
    }
  }
}
