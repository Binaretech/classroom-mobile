import 'package:classroom_mobile/lang/lang.dart';
import 'package:classroom_mobile/modules/auth/widgets/google_sign_in_button.dart';
import 'package:classroom_mobile/repository/auth_repository.dart';
import 'package:classroom_mobile/utils/validation.dart';
import 'package:flutter/material.dart';
import 'package:classroom_mobile/modules/auth/widgets/auth_title.dart';
import 'package:classroom_mobile/widgets/password_input.dart';

/// A form to register a new user.
class RegisterData {
  String? email;
  String? password;
  String? passwordConfirmation;
}

/// Register screen for new users to create an account on the app.
class Register extends StatefulWidget {
  final AuthRepository repository;
  const Register({Key? key, required this.repository}) : super(key: key);

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final _formKey = GlobalKey<FormState>();
  final RegisterData _registerData = RegisterData();

  bool remember = false;

  bool isLoading = false;

  @override
  dispose() {
    widget.repository.close();
    super.dispose();
  }

  submit() {
    _formKey.currentState!.save();

    if (_formKey.currentState!.validate()) {
      setState(() {
        isLoading = true;
      });

      widget.repository
          .register(
        email: _registerData.email ?? '',
        password: _registerData.password ?? '',
      )
          .then((response) {
        Navigator.restorablePushNamedAndRemoveUntil(
            context, '/', (route) => false);
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
    final navigator = Navigator.of(context);

    navigator.pushNamed('/login');
  }

  Widget inputs() {
    final lang = Lang.of(context);

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          child: TextFormField(
            onSaved: (value) {
              _registerData.email = value;
            },
            keyboardType: TextInputType.emailAddress,
            style: const TextStyle(
              fontSize: 16.0,
            ),
            validator: rules([requiredRule, emailRule]),
            decoration: InputDecoration(
              border: const OutlineInputBorder(),
              labelText: lang.trans(
                'attributes.email',
                capitalize: true,
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          child: PasswordInput(
            onSaved: (value) {
              _registerData.password = value;
            },
            validator: rules([requiredRule]),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          child: PasswordInput(
            label: lang.trans('attributes.password_confirm', capitalize: true),
            onSaved: (value) {
              _registerData.passwordConfirmation = value;
            },
            validator: rules([
              requiredRule,
            ]),
          ),
        ),
      ],
    );
  }

  Widget loginLink() {
    final lang = Lang.of(context);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: Text(
              lang.trans('views.register.have_an_account', capitalize: true),
              style: const TextStyle(
                fontSize: 14.0,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          GestureDetector(
            onTap: () => login(context),
            child: Text(
              lang.trans('views.register.login', capitalize: true),
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
                      title: lang.trans('views.register.title'),
                    ),
                    Form(
                      key: _formKey,
                      child: inputs(),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20.0),
                      child: rememberCheck(),
                    ),
                    ElevatedButton(
                      onPressed: isLoading ? null : submit,
                      child: Text(
                        lang.trans('messages.accept').toUpperCase(),
                        style: const TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 14.0,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size.fromHeight(40.0),
                      ),
                    ),
                    GoogleSignInButton(
                      authRepository: widget.repository,
                    ),
                    loginLink(),
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
