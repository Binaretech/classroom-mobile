import 'package:classroom_mobile/http/service.dart';
import 'package:classroom_mobile/utils/validation.dart';
import 'package:flutter/material.dart';
import 'package:classroom_mobile/modules/auth/widgets/auth_title.dart';
import 'package:classroom_mobile/widgets/password_input.dart';
import 'package:intl/intl.dart';
import 'package:classroom_mobile/l10n/localization.dart';

class RegisterData {
  String? email;
  String? password;
}

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final _formKey = GlobalKey<FormState>();
  final RegisterData _loginData = RegisterData();

  bool remember = false;

  submit() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      login(_loginData.email ?? '', _loginData.password ?? '')
          .then((value) => print(value))
          .catchError((error) => print(error));
    }
  }

  toggleRemember(value) {
    setState(() {
      remember = value ?? false;
    });
  }

  Widget inputs(AppLocalizations localization) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          child: TextFormField(
            onSaved: (value) {
              _loginData.email = value;
            },
            keyboardType: TextInputType.emailAddress,
            style: const TextStyle(
              fontSize: 16.0,
            ),
            validator: rules(localization, [requiredRule, emailRule]),
            decoration: InputDecoration(
              border: const OutlineInputBorder(),
              labelText: toBeginningOfSentenceCase(localization.email),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          child: PasswordInput(
            onSaved: (value) {
              _loginData.password = value;
            },
            validator: rules(localization, [requiredRule]),
          ),
        ),
      ],
    );
  }

  Widget registerLink(AppLocalizations localization) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            toBeginningOfSentenceCase(localization.dontHaveAnAccount)!,
            style: const TextStyle(
              fontSize: 14.0,
              fontWeight: FontWeight.w500,
            ),
          ),
          Text(
            toBeginningOfSentenceCase(localization.register)!,
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 14.0,
              color: Theme.of(context).primaryColor,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizations.of(context)!;

    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                AuthTitle(
                  title: toBeginningOfSentenceCase(
                    localization.createAccount,
                  )!,
                ),
                Form(
                  key: _formKey,
                  child: inputs(localization),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Radio(
                            value: true,
                            groupValue: remember,
                            toggleable: true,
                            onChanged: toggleRemember,
                          ),
                          Text(
                            toBeginningOfSentenceCase(localization.rememberMe)!,
                            style: const TextStyle(
                              fontSize: 12.0,
                            ),
                          ),
                        ],
                      ),
                      Text(
                        toBeginningOfSentenceCase(localization.forgotPassword)!,
                        style: TextStyle(
                          fontSize: 12.0,
                          color: Theme.of(context).primaryColorDark,
                        ),
                      ),
                    ],
                  ),
                ),
                ElevatedButton(
                  onPressed: submit,
                  child: Text(toBeginningOfSentenceCase(localization.accept)!),
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size.fromHeight(40.0),
                  ),
                ),
                registerLink(localization),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
