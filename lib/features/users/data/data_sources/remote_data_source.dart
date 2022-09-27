import 'package:dartz/dartz.dart';
import 'package:pospank_notes/core/app_constants/api_constants.dart';

import 'package:pospank_notes/core/errors/exceptions.dart';
import 'package:pospank_notes/features/notes/data/models/note_model.dart';
import 'package:dio/dio.dart';
import 'package:pospank_notes/features/users/data/models/interest_model.dart';
import 'package:pospank_notes/features/users/data/models/user_model.dart';

abstract class RemoteDataSourceUser {
  Future<List<UserModel>> getAllUsers();
  Future<List<InterestModel>> getAllInterest();
  Future<Unit> insertUser(UserModel userModel);
}

class RemoteDataSourceUserImpl implements RemoteDataSourceUser {
  final Dio dio;

  RemoteDataSourceUserImpl({required this.dio});
  @override
  Future<List<UserModel>> getAllUsers() async {
    final response =
        await dio.get('https://noteapi.popssolutions.net/users/getall');
    print(response);
    if (response.statusCode == 200) {
      final List jsonData = response.data as List;
      final List<UserModel> userModel = jsonData
          .map<UserModel>((jsonUserModel) => UserModel.fromJson(jsonUserModel))
          .toList();
      print(response);
      return userModel;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<Unit> insertUser(UserModel userModel) async {
    final body = {
      'username': userModel.username,
      'imageAsBase64': userModel.imageAsBase64,
      'email': userModel.email,
      'entrestId': userModel.interestId,
      'password': userModel.password,
    };

    final response = await dio.post(
      '$BASE_URL/users/insert',
      data: body,
    );
    if (response.statusCode == 200) {
      return Future.value(unit);
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<InterestModel>> getAllInterest() async {
    final response = await dio.get(
      '$BASE_URL/intrests/getall',
    );
    if (response.statusCode == 200) {
      final List jsonData = response.data as List;
      final List<InterestModel> model = jsonData
          .map<InterestModel>(
              (jsonInterestModel) => InterestModel.fromJson(jsonInterestModel))
          .toList();
      return model;
    } else {
      throw ServerException();
    }
  }
}
