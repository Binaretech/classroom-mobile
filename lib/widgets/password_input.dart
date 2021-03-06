import 'package:classroom_mobile/lang/lang.dart';
import 'package:flutter/material.dart';

/// A [TextFormField] that handles password input.
class PasswordInput extends StatefulWidget {
  final void Function(String?)? onSaved;
  final String? Function(String?)? validator;
  final String? label;

  const PasswordInput({Key? key, this.validator, this.onSaved, this.label})
      : super(key: key);

  @override
  PasswordInputState createState() => PasswordInputState();
}

class PasswordInputState extends State<PasswordInput> {
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
        labelText: widget.label ??
            Lang.of(context).trans('attributes.password', capitalize: true),
        suffixIcon: IconButton(
          icon: const Icon(Icons.remove_red_eye),
          onPressed: () => _toggleObscureText(),
        ),
      ),
    );
  }
}
