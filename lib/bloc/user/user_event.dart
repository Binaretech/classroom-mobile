part of 'user_bloc.dart';

abstract class UserEvent extends Equatable {
  const UserEvent();
}

class SetUserEvent extends UserEvent {
  final String id;
  final String name;
  final String lastname;

  const SetUserEvent(
      {required this.id, required this.name, required this.lastname});

  @override
  List<Object> get props => [id, name, lastname];
}

class RemoveUserEvent extends UserEvent {
  const RemoveUserEvent();

  @override
  List<Object> get props => [];
}
