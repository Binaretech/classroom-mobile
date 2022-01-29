import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

enum AuthenticationStatus { unknown, authenticated, unauthenticated }

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  AuthenticationBloc() : super(const AuthenticationState.unknown()) {
    on<AuthenticationEvent>(
        (event, emit) => emit(const AuthenticationState.unknown()));
  }
}
