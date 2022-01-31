import 'package:classroom_mobile/repository/auth_repository.dart';
import 'package:classroom_mobile/router/router_page_manager.dart';
import 'package:classroom_mobile/utils/validation.dart';
import 'package:flutter/material.dart';
import 'package:classroom_mobile/modules/auth/widgets/auth_title.dart';
import 'package:classroom_mobile/widgets/password_input.dart';
import 'package:intl/intl.dart';
import 'package:classroom_mobile/l10n/localization.dart';

class LoginData {
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
  final LoginData _loginData = LoginData();

  bool remember = false;

  bool isLoading = false;

  submit() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      setState(() {
        isLoading = true;
      });

      register(
        email: _loginData.email ?? '',
        password: _loginData.password ?? '',
      ).then((response) {
        setState(() {
          isLoading = false;
        });
      }).catchError((_) {
        setState(() {
          isLoading = false;
        });
      });
    }
  }

  toggleRemember(value) {
    setState(() {
      remember = value ?? false;
    });
  }

  void login(BuildContext context) {
    RouterPageManager.of(context).push('/login');
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

  Widget loginLink(BuildContext context, AppLocalizations localization) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            toBeginningOfSentenceCase(localization.haveAnAccount)!,
            style: const TextStyle(
              fontSize: 14.0,
              fontWeight: FontWeight.w500,
            ),
          ),
          GestureDetector(
            onTap: () => login(context),
            child: Text(
              toBeginningOfSentenceCase(localization.login)!,
              style: const TextStyle(
                fontSize: 14.0,
                fontWeight: FontWeight.w500,
                color: Colors.blue,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget rememberCheck(AppLocalizations localization) {
    return Row(
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
    );
  }

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizations.of(context)!;

    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: [
              isLoading ? const LinearProgressIndicator() : Container(),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    AuthTitle(
                      title: toBeginningOfSentenceCase(
                        localization.register,
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
                          rememberCheck(localization),
                          Text(
                            toBeginningOfSentenceCase(
                                localization.forgotPassword)!,
                            style: TextStyle(
                              fontSize: 12.0,
                              color: Theme.of(context).primaryColorDark,
                            ),
                          ),
                        ],
                      ),
                    ),
                    ElevatedButton(
                      onPressed: isLoading ? null : submit,
                      child:
                          Text(toBeginningOfSentenceCase(localization.accept)!),
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size.fromHeight(40.0),
                      ),
                    ),
                    loginLink(context, localization),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
