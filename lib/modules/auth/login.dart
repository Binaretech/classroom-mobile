import 'package:classroom_mobile/bloc/authentication/authentication_bloc.dart';
import 'package:classroom_mobile/repository/auth_repository.dart';
import 'package:classroom_mobile/utils/validation.dart';
import 'package:flutter/material.dart';
import 'package:classroom_mobile/modules/auth/widgets/auth_title.dart';
import 'package:classroom_mobile/widgets/password_input.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:classroom_mobile/l10n/localization.dart';

/// Form data to be submitted to the server
class LoginData {
  String? email;
  String? password;
}

/// Login screen for the application that allows the user to login with their email and password credentials and then redirects to the home screen if successful
class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>();
  final LoginData _loginData = LoginData();

  bool remember = false;

  bool isLoading = false;

  submit() {
    return () {
      if (_formKey.currentState!.validate()) {
        _formKey.currentState!.save();

        setState(() {
          isLoading = true;
        });

        login(
          email: _loginData.email ?? '',
          password: _loginData.password ?? '',
        ).then((value) {
          context
              .read<AuthenticationBloc>()
              .add(AuthenticationStatusChanged(token: value.token.accessToken));

          Navigator.restorablePushNamedAndRemoveUntil(
              context, '/', (route) => false);
        }).catchError((error) {
          setState(() {
            isLoading = false;
          });
        });
      }
    };
  }

  toggleRemember(value) {
    setState(() {
      remember = value ?? false;
    });
  }

  void register(BuildContext context) {
    final navigator = Navigator.of(context);

    navigator.pushNamed('/register');
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

  Widget registerLink(BuildContext context, AppLocalizations localization) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            toBeginningOfSentenceCase(localization.dontHaveAnAccount)! + ' ',
            style: const TextStyle(
              fontSize: 14.0,
              fontWeight: FontWeight.w500,
            ),
          ),
          GestureDetector(
            onTap: () => register(context),
            child: Text(
              toBeginningOfSentenceCase(localization.register)!,
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
                        localization.login,
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
                      onPressed: isLoading ? null : submit(),
                      child:
                          Text(toBeginningOfSentenceCase(localization.accept)!),
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size.fromHeight(40.0),
                      ),
                    ),
                    registerLink(context, localization),
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
