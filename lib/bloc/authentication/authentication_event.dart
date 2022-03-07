part of 'authentication_bloc.dart';

abstract class AuthenticationEvent extends Equatable {
  const AuthenticationEvent();

  @override
  List<Object> get props => [];
}

class AuthenticationStatusChanged extends AuthenticationEvent {
  final String token;

  const AuthenticationStatusChanged({this.token = ''});

  get isAuthenticated => token.isNotEmpty;

  @override
  List<Object> get props => [token];

  @override
  String toString() =>
      'AuthenticationStatusChanged { status: $isAuthenticated }';
}
