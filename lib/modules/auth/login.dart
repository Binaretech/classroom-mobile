import 'package:classroom_mobile/bloc/authentication/authentication_bloc.dart';
import 'package:classroom_mobile/lang/lang.dart';
import 'package:classroom_mobile/modules/auth/widgets/google_sign_in_button.dart';
import 'package:classroom_mobile/repository/auth_repository.dart';
import 'package:classroom_mobile/utils/validation.dart';
import 'package:flutter/material.dart';
import 'package:classroom_mobile/modules/auth/widgets/auth_title.dart';
import 'package:classroom_mobile/widgets/password_input.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// Form data to be submitted to the server
class LoginData {
  String? email;
  String? password;
}

/// Login screen for the application that allows the user to login with their email and password credentials and then redirects to the home screen if successful
class Login extends StatefulWidget {
  final AuthRepository repository;

  static const route = '/login';

  const Login({Key? key, required this.repository}) : super(key: key);

  @override
  LoginState createState() => LoginState();
}

class LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>();
  final LoginData _loginData = LoginData();

  bool remember = false;

  bool isLoading = false;

  @override
  dispose() {
    widget.repository.close();

    super.dispose();
  }

  submit() {
    return () {
      if (_formKey.currentState!.validate()) {
        _formKey.currentState!.save();

        setState(() {
          isLoading = true;
        });

        widget.repository
            .login(
          email: _loginData.email ?? '',
          password: _loginData.password ?? '',
        )
            .then((value) {
          context
              .read<AuthenticationBloc>()
              .add(AuthenticateUser(value.token.accessToken));

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

  Widget inputs() {
    final lang = Lang.of(context);

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
            validator: rules([requiredRule, emailRule]),
            decoration: InputDecoration(
              border: const OutlineInputBorder(),
              labelText: lang.trans('attributes.email', capitalize: true),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          child: PasswordInput(
            onSaved: (value) {
              _loginData.password = value;
            },
            validator: rules([requiredRule]),
          ),
        ),
      ],
    );
  }

  Widget registerLink() {
    final lang = Lang.of(context);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: Text(
              lang.trans('views.login.dont_have_an_account', capitalize: true),
              style: const TextStyle(
                fontSize: 14.0,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          GestureDetector(
            onTap: () => register(context),
            child: Text(
              lang.trans('views.login.register', capitalize: true),
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

  Widget rememberCheck() {
    final lang = Lang.of(context);

    return Row(
      children: [
        Radio(
          value: true,
          groupValue: remember,
          toggleable: true,
          onChanged: toggleRemember,
        ),
        Text(
          lang.trans('views.login.remember_me', capitalize: true),
          style: const TextStyle(
            fontSize: 12.0,
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final lang = Lang.of(context);

    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: [
              isLoading ? const LinearProgressIndicator() : Container(),
              Padding(
                padding: const EdgeInsets.all(40.0),
                child: Column(
                  children: [
                    AuthTitle(
                      title: lang.trans('views.login.title', capitalize: true),
                    ),
                    Form(
                      key: _formKey,
                      child: inputs(),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          rememberCheck(),
                          Text(
                            lang.trans('views.login.forgot_password'),
                            style: TextStyle(
                              fontSize: 12.0,
                              color: Theme.of(context).colorScheme.primary,
                            ),
                          ),
                        ],
                      ),
                    ),
                    ElevatedButton(
                      onPressed: isLoading ? null : submit(),
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size.fromHeight(40.0),
                      ),
                      child: Text(
                        lang.trans('messages.accept').toUpperCase(),
                        style: const TextStyle(
                            fontWeight: FontWeight.w700, fontSize: 14.0),
                      ),
                    ),
                    GoogleSignInButton(
                      authRepository: widget.repository,
                    ),
                    registerLink(),
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
