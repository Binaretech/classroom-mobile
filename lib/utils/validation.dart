import 'package:classroom_mobile/l10n/localization.dart';
import 'package:intl/intl.dart';

typedef Rule = String? Function(AppLocalizations, String?);

/// Pipeline of rules to apply to a string.
String? Function(String?) rules(AppLocalizations localization,
    List<String? Function(AppLocalizations, String?)> fns) {
  return (String? input) {
    for (Rule fn in fns) {
      final result = fn(localization, input);
      if (result != null) {
        return toBeginningOfSentenceCase(result);
      }
    }

    return null;
  };
}

/// A [Rule] that check if the input is not empty.
String? requiredRule(AppLocalizations localization, String? input) {
  if (input?.isEmpty ?? false) {
    return localization.required;
  }
  return null;
}

/// A [Rule] that check if the input is a valid email.
String? emailRule(AppLocalizations localization, String? input) {
  if (input == null || input.isEmpty) {
    return null;
  }

  if (!RegExp(r'^[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,8}$', caseSensitive: false)
      .hasMatch(input)) {
    return localization.invalidEmail;
  }

  return null;
}

/// A [Rule] that check if the input is equals to the [value] input.
String? Function(AppLocalizations, String?) equalsRule(
    String? Function() value, String value1, String value2) {
  return (AppLocalizations localization, String? input) {
    if (input != value()) {
      return localization.equalsRule(value1, value2);
    }

    return null;
  };
}
