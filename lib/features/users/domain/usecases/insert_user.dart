import 'package:dartz/dartz.dart';

import 'package:pospank_notes/features/users/domain/entities/user.dart';
import 'package:pospank_notes/features/users/domain/repositories/user_repo.dart';

import '../../../../core/errors/failures.dart';

class InsertUserUseCase {
  final UserRepo userRepo;

  InsertUserUseCase(this.userRepo);

  Future<Either<Failure, Unit>> call(User user) async {
    return await userRepo.insertUser(user);
  }
}
