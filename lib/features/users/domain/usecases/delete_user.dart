import 'package:dartz/dartz.dart';
import 'package:pospank_notes/features/users/domain/repositories/user_repo.dart';

import '../../../../core/errors/failures.dart';
import '../entities/user.dart';

class DeleteUserUseCase {
  final UserRepo userRepo;

  DeleteUserUseCase(this.userRepo);

  // Future<Either<Failure, Unit>> call(User user) async {
  //   return await userRepo.deleteUser(user);
  // }
}
