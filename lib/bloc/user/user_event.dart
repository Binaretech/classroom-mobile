part of 'user_bloc.dart';

abstract class UserEvent extends Equatable {
  const UserEvent();
}

class SetUserEvent extends UserEvent {
  final User user;
  const SetUserEvent({required this.user});

  @override
  List<Object> get props => [user];
}

class RemoveUserEvent extends UserEvent {
  const RemoveUserEvent();

  @override
  List<Object> get props => [];
}
