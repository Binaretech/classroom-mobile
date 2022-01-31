import 'package:classroom_mobile/globals.dart';
import 'package:classroom_mobile/http/request.dart';
import 'package:flutter/material.dart';

bool hasResponseErrors(Response response) {
  if (response.statusCode >= 200 && response.statusCode < 300) {
    return false;
  }

  snackbarKey.currentState?.showSnackBar(SnackBar(
    content: Text(extractErrorFromResponse(response)),
    duration: const Duration(seconds: 3),
  ));

  return true;
}

String extractErrorFromResponse(Response response) {
  if (response.data.containsKey('error')) {
    return response.data['error'];
  }

  return 'Unknown error';
}
