import 'package:dartz/dartz.dart';
import 'package:pospank_notes/features/users/domain/entities/interest.dart';
import 'package:pospank_notes/features/users/domain/entities/user.dart';

import '../../../../core/errors/failures.dart';

abstract class UserRepo {
  Future<Either<Failure, List<User>>> getAllUsers();
  Future<Either<Failure, Unit>> insertUser(User user);

  Future<Either<Failure, List<Interest>>> getAllInterests();
}
