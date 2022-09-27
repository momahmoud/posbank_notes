import 'package:pospank_notes/core/errors/exceptions.dart';

import 'package:pospank_notes/core/errors/failures.dart';
import 'package:dartz/dartz.dart';

import 'package:pospank_notes/features/users/data/models/user_model.dart';
import 'package:pospank_notes/features/users/domain/entities/interest.dart';
import 'package:pospank_notes/features/users/domain/entities/user.dart';
import 'package:pospank_notes/features/users/domain/repositories/user_repo.dart';

import '../../../../core/network/network_info.dart';
import '../data_sources/local_data_source.dart';
import '../data_sources/remote_data_source.dart';

typedef ClearOrUpdateOrInsertUser = Future<Unit> Function();

class UserRepoImpl implements UserRepo {
  final RemoteDataSourceUser remoteDataSource;
  final NetworkInfo networkInfo;
  final LocalDataSourceUser localDataSource;

  UserRepoImpl({
    required this.remoteDataSource,
    required this.networkInfo,
    required this.localDataSource,
  });

  @override
  Future<Either<Failure, List<User>>> getAllUsers() async {
    if (await networkInfo.isConnected) {
      try {
        final remoteUsers = await remoteDataSource.getAllUsers();
        final remoteInterest = await remoteDataSource.getAllInterest();
        localDataSource.cachedInterestsAndUsers(remoteUsers, remoteInterest);

        return Right(
          remoteUsers,
        );
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      try {
        final localUsers = await localDataSource.getCachedUsers();

        return Right(localUsers);
      } on DatabaseCacheException {
        return Left(DatabaseCacheFailure());
      }
    }
  }

  @override
  Future<Either<Failure, Unit>> insertUser(User user) async {
    final UserModel model = UserModel(
      username: user.username,
      email: user.email,
      id: user.id,
      interestId: user.interestId,
      password: user.password,
      imageAsBase64: user.imageAsBase64,
    );
    if (await networkInfo.isConnected) {
      return _getMessage(() {
        return remoteDataSource.insertUser(model);
      });
    } else {
      return _getMessage(() {
        return localDataSource.insertUser(model);
      });
    }
  }

  @override
  Future<Either<Failure, List<Interest>>> getAllInterests() async {
    if (await networkInfo.isConnected) {
      try {
        final remoteUsers = await remoteDataSource.getAllUsers();
        final remoteInterest = await remoteDataSource.getAllInterest();
        localDataSource.cachedInterestsAndUsers(remoteUsers, remoteInterest);

        return Right(
          remoteInterest,
        );
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      try {
        final localInterests = await localDataSource.getCachedInterest();
        return Right(localInterests);
      } on DatabaseCacheException {
        return Left(DatabaseCacheFailure());
      }
    }
  }

  Future<Either<Failure, Unit>> _getMessage(
      ClearOrUpdateOrInsertUser clearOrUpdateOrInsertUser) async {
    try {
      await clearOrUpdateOrInsertUser();
      return const Right(unit);
    } on ServerException {
      return Left(ServerFailure());
    }
  }
}
