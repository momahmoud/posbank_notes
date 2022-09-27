import 'package:dartz/dartz.dart';

import 'package:pospank_notes/features/users/domain/entities/user.dart';
import 'package:pospank_notes/features/users/domain/repositories/user_repo.dart';

import '../../../../core/errors/failures.dart';

class GetAllUserUseCases {
  final UserRepo userRepo;

  GetAllUserUseCases(this.userRepo);

  Future<Either<Failure, List<User>>> call() async {
    return await userRepo.getAllUsers();
  }
}
