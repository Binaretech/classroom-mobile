import 'package:classroom_mobile/lang/es/es.dart';
import 'package:flutter/material.dart';

final _store = {
  'es': es,
};

const allowedLocales = ['es'];

/// Handles the localization of the app based on the device's locale and the available translations.
/// The translations are stored in a map, where the key is the locale and the value is the map of translations.
class Lang {
  final Locale locale;

  Lang(this.locale);

  /// Create a Lang instance based on the device's locale.
  factory Lang.of(BuildContext context) {
    return Lang(Localizations.localeOf(context));
  }

  /// Returns the translation for the given translation string. If the translation is not found, the string is returned
  String trans(String text,
      {bool capitalize = false, Map<String, String> replace = const {}}) {
    if (!allowedLocales.contains(locale.languageCode)) {
      return text;
    }

    final split = text.split('.');

    dynamic message = _store[locale.languageCode];

    for (final part in split) {
      if (!(message?.containsKey(part) ?? false)) {
        return text;
      }

      message = message[part];
    }

    if (message is String) {
      final str = replace.entries.fold<String>(
        message,
        (previousValue, element) => previousValue.replaceAll(
            RegExp(r'\{\{${element.key}\}\}'), element.value),
      );

      if (capitalize) {
        return str.substring(0, 1).toUpperCase() + str.substring(1);
      }

      return str;
    }

    return text;
  }
}
