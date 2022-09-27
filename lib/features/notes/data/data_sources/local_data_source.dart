import 'dart:convert';

import 'package:dartz/dartz.dart';

import 'package:pospank_notes/features/notes/data/models/note_model.dart';

import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/errors/exceptions.dart';

abstract class LocalDataSource {
  Future<List<NoteModel>> getCachedNotes();
  Future<Unit> clearNotes();
  Future<Unit> updateNotes(NoteModel noteModel);
  Future<Unit> insertNotes(NoteModel noteModel);
  Future<Unit> cachedNotes(List<NoteModel> postModels);
}

class LocalDataSourceImpl implements LocalDataSource {
  final SharedPreferences sharedPreferences;

  LocalDataSourceImpl({required this.sharedPreferences});
  @override
  Future<Unit> cachedNotes(List<NoteModel> noteModels) {
    final noteModelsToJson =
        noteModels.map((noteModels) => noteModels.toJson()).toList();
    sharedPreferences.setString('CACHED_Notes', json.encode(noteModelsToJson));

    return Future.value(unit);
  }

  @override
  Future<List<NoteModel>> getCachedNotes() {
    final jsonString = sharedPreferences.getString('CACHED_Notes');
    if (jsonString != null) {
      List decodedJsonData = json.decode(jsonString);
      List<NoteModel> jsonToNoteModel = decodedJsonData
          .map<NoteModel>((jsonNoteModel) => NoteModel.fromJson(jsonNoteModel))
          .toList();
      return Future.value(jsonToNoteModel);
    } else {
      throw DatabaseCacheException();
    }
  }

  @override
  Future<Unit> clearNotes() {
    sharedPreferences.remove('CACHED_Notes');
    return Future.value(unit);
  }

  @override
  Future<Unit> insertNotes(NoteModel noteModel) {
    final body = {
      'id': noteModel.id,
      'text': noteModel.text,
      'userId': noteModel.userId,
      'placeDateTime': noteModel.placeDateTime,
    };
    // sharedPreferences.setStringList('CACHED_Notes', body);
    // TODO: implement insertNotes
    throw UnimplementedError();
  }

  @override
  Future<Unit> updateNotes(NoteModel noteModel) {
    // TODO: implement updateNotes
    throw UnimplementedError();
  }
}
