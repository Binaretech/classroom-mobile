import 'package:classroom_mobile/bloc/authentication/authentication_bloc.dart';
import 'package:classroom_mobile/bloc/user/user_bloc.dart';
import 'package:classroom_mobile/globals.dart';
import 'package:classroom_mobile/http/request.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// If the response status is 401 Unauthorized, the user is not logged in.
/// The user is redirected to the login page and the user data is cleared.
bool checkUnauthenticated(Response response) {
  if (response.statusCode == 401) {
    final authBloc =
        BlocProvider.of<AuthenticationBloc>(navigatorKey.currentContext!);

    final userBloc = BlocProvider.of<UserBloc>(navigatorKey.currentContext!);

    authBloc.add(const UnauthenticateUser());
    userBloc.add(const RemoveUserEvent());

    navigatorKey.currentState
        ?.restorablePushNamedAndRemoveUntil('/login', (route) => false);
    return true;
  }

  return false;
}

/// Check if the response status is not 200 OK.
/// if there is an error message, it is shown to the user with a snackbar.
bool hasResponseErrors(Response response) {
  if (response.statusCode >= 200 && response.statusCode < 300) {
    return false;
  }

  if (checkUnauthenticated(response)) {
    return true;
  }

  snackbarKey.currentState?.showSnackBar(SnackBar(
    content: Text(extractErrorFromResponse(response)),
    duration: const Duration(seconds: 3),
  ));

  return true;
}

/// Extracts the error message from the response.
String extractErrorFromResponse(Response response) {
  if (response.data.containsKey('validationErrors')) {
    return extractValidationErrors(
        response.data['validationErrors'] as Map<String, dynamic>);
  }

  if (response.data.containsKey('message')) {
    return response.data['message'] as String;
  }

  if (response.data.containsKey('error')) {
    return response.data['error'];
  }

  return 'Unknown error';
}

/// Format the validation errors into a string.
String extractValidationErrors(Map<String, dynamic> validationErrors) {
  return validationErrors.values.map((error) => error.join(', ')).join('\n');
}
