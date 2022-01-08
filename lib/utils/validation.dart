import 'package:classroom_mobile/l10n/localization.dart';
import 'package:intl/intl.dart';

typedef Rule = String? Function(AppLocalizations, String?);

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

String? requiredRule(AppLocalizations localization, String? input) {
  if (input?.isEmpty ?? false) {
    return localization.required;
  }
  return null;
}

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
