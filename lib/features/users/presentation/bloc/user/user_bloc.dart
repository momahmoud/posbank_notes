import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:pospank_notes/features/users/domain/entities/user.dart';
import 'package:pospank_notes/features/users/domain/usecases/get_all_interests.dart';
import 'package:pospank_notes/features/users/domain/usecases/get_all_users.dart';
import 'package:pospank_notes/features/users/domain/usecases/insert_user.dart';

import '../../../../../core/app_strings/failures_message.dart';
import '../../../../../core/errors/failures.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final GetAllUserUseCases getAllUser;
  final GetAllInterestsUseCase getAllInterests;
  final InsertUserUseCase insertUser;

  UserBloc({
    required this.getAllUser,
    required this.getAllInterests,
    required this.insertUser,
  }) : super(UserInitial()) {
    on<UserEvent>((event, emit) async {
      if (event is GetAllUserEvent) {
        emit(LoadingUserState());
        final failureOrNotes = await getAllUser();
        emit(_mapFailureOrNotesToState(failureOrNotes));
      } else if (event is RefreshUserEvent) {
        emit(LoadingUserState());
        final failureOrUser = await getAllUser();
        emit(_mapFailureOrNotesToState(failureOrUser));
      }
    });
  }

  UserState _mapFailureOrNotesToState(
      Either<Failure, List<User>> failureOrUser) {
    return failureOrUser.fold(
      (failure) => ErrorUserState(message: _mapFailureToMessage(failure)),
      (user) => LoadedUserState(user: user),
    );
  }

  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return SERVER_FAILURE_MESSAGE;

      case OfflineFailure:
        return OFFLINE_FAILURE_MESSAGE;

      default:
        return "Unexpected Error, Please try again later.";
    }
  }
}
