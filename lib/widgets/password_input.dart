import 'package:flutter/material.dart';
import 'package:classroom_mobile/l10n/localization.dart';
import 'package:intl/intl.dart';

/// A [TextFormField] that handles password input.
class PasswordInput extends StatefulWidget {
  final void Function(String?)? onSaved;
  final String? Function(String?)? validator;
  final String? label;

  const PasswordInput({Key? key, this.validator, this.onSaved, this.label})
      : super(key: key);

  @override
  _PasswordInputState createState() => _PasswordInputState();
}

class _PasswordInputState extends State<PasswordInput> {
  bool _obscureText = true;

  void _toggleObscureText() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: widget.validator,
      onSaved: widget.onSaved,
      obscureText: _obscureText,
      decoration: InputDecoration(
        border: const OutlineInputBorder(),
        labelText: toBeginningOfSentenceCase(
            widget.label ?? AppLocalizations.of(context)!.password),
        suffixIcon: IconButton(
          icon: const Icon(Icons.remove_red_eye),
          onPressed: () => _toggleObscureText(),
        ),
      ),
    );
  }
}
