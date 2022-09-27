import 'package:dartz/dartz.dart';
import 'package:pospank_notes/features/users/domain/entities/interest.dart';

import 'package:pospank_notes/features/users/domain/repositories/user_repo.dart';

import '../../../../core/errors/failures.dart';

class GetAllInterestsUseCase {
  final UserRepo userRepo;

  GetAllInterestsUseCase(this.userRepo);

  Future<Either<Failure, List<Interest>>> call() async {
    return await userRepo.getAllInterests();
  }
}
