import 'dart:convert';

import 'package:dartz/dartz.dart';

import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/errors/exceptions.dart';
import '../models/interest_model.dart';
import '../models/user_model.dart';

abstract class LocalDataSourceUser {
  Future<List<UserModel>> getCachedUsers();
  Future<List<InterestModel>> getCachedInterest();
  Future<Unit> insertUser(UserModel userModel);
  Future<Unit> cachedInterestsAndUsers(
      List<UserModel> userModel, List<InterestModel> interestModel);
}

class LocalDataSourceUserImpl implements LocalDataSourceUser {
  final SharedPreferences sharedPreferences;

  LocalDataSourceUserImpl({required this.sharedPreferences});
  @override
  Future<Unit> cachedInterestsAndUsers(
      List<UserModel> userModel, List<InterestModel> interestModel) {
    //cached users
    final userModelsToJson =
        userModel.map((userModels) => userModels.toJson()).toList();
    sharedPreferences.setString('CACHED_User', json.encode(userModelsToJson));
    //cached interest
    final interestModelsToJson =
        interestModel.map((interestModels) => interestModels.toJson()).toList();
    sharedPreferences.setString(
        'CACHED_Interest', json.encode(interestModelsToJson));

    return Future.value(unit);
  }

  @override
  Future<List<UserModel>> getCachedUsers() {
    final jsonString = sharedPreferences.getString('CACHED_User');
    if (jsonString != null) {
      List decodedJsonData = json.decode(jsonString);
      List<UserModel> jsonToNoteModel = decodedJsonData
          .map<UserModel>((jsonNoteModel) => UserModel.fromJson(jsonNoteModel))
          .toList();
      return Future.value(jsonToNoteModel);
    } else {
      throw DatabaseCacheException();
    }
  }

  @override
  Future<List<InterestModel>> getCachedInterest() {
    final jsonString = sharedPreferences.getString('CACHED_Interest');
    if (jsonString != null) {
      List decodedJsonData = json.decode(jsonString);
      List<InterestModel> jsonToInterestModel = decodedJsonData
          .map<InterestModel>(
              (jsonInterestModel) => InterestModel.fromJson(jsonInterestModel))
          .toList();
      return Future.value(jsonToInterestModel);
    } else {
      throw DatabaseCacheException();
    }
  }

  @override
  Future<Unit> insertUser(UserModel userModel) {
    final body = {
      'username': userModel.username,
      'imageAsBase64': userModel.imageAsBase64,
      'email': userModel.email,
      'entrestId': userModel.interestId,
      'password': userModel.password,
    };
    // sharedPreferences.setStringList('CACHED_Notes', body);
    // TODO: implement insertNotes
    throw UnimplementedError();
  }
}
