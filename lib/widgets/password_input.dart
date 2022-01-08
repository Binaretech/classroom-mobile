import 'package:flutter/material.dart';
import 'package:classroom_mobile/l10n/localization.dart';
import 'package:intl/intl.dart';

class PasswordInput extends StatefulWidget {
  final void Function(String?)? onSaved;
  final String? Function(String?)? validator;

  const PasswordInput({Key? key, this.validator, this.onSaved})
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
        labelText:
            toBeginningOfSentenceCase(AppLocalizations.of(context)!.password),
        suffixIcon: IconButton(
          icon: const Icon(Icons.remove_red_eye),
          onPressed: () => _toggleObscureText(),
        ),
      ),
    );
  }
}
