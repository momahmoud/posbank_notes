part of 'user_bloc.dart';

abstract class UserEvent extends Equatable {
  const UserEvent();

  @override
  List<Object> get props => [];
}

class GetAllUserEvent extends UserEvent {}

class GetAllInterestEvent extends UserEvent {}

class RefreshUserEvent extends UserEvent {}

class InsertUserEvent extends UserEvent {
  final User user;

  const InsertUserEvent({required this.user});

  @override
  List<Object> get props => [user];
}

class ClearNoteEvent extends UserEvent {}
