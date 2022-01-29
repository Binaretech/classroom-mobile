part of 'authentication_bloc.dart';

class AuthenticationState extends Equatable {
  final AuthenticationStatus status;

  const AuthenticationState._({
    this.status = AuthenticationStatus.unknown,
  });

  const AuthenticationState.unknown() : this._();

  @override
  List<Object> get props => [status];
}
