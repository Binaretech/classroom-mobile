import 'package:classroom_mobile/l10n/localization.dart';
import 'package:classroom_mobile/lang/lang.dart';
import 'package:classroom_mobile/widgets/avatar.dart';
import 'package:flutter/material.dart';

/// Form data to be submitted to the server
class LoginData {
  String? name;
  String? lastname;
}

class RegisterUserInfo extends StatefulWidget {
  const RegisterUserInfo({Key? key}) : super(key: key);

  @override
  _RegisterUserInfoState createState() => _RegisterUserInfoState();
}

class _RegisterUserInfoState extends State<RegisterUserInfo> {
  final _formKey = GlobalKey<FormState>();
  final LoginData _loginData = LoginData();

  void _submit() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final lang = Lang.of(context);

    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 41),
        child: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: Text(
                  lang.trans('views.register_user_info.title'),
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 36,
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 20),
                child: SizedBox(
                  width: double.infinity,
                  child: Center(
                    child: Avatar(
                      radius: 75.0,
                      iconSize: 80.0,
                    ),
                  ),
                ),
              ),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16.0),
                      child: TextFormField(
                        onSaved: (value) => _loginData.name = value,
                        decoration: InputDecoration(
                          border: const OutlineInputBorder(),
                          label: Text(
                            lang.trans('attributes.name', capitalize: true),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16.0),
                      child: TextFormField(
                        onSaved: (value) => _loginData.name = value,
                        decoration: InputDecoration(
                          border: const OutlineInputBorder(),
                          label: Text(
                            lang.trans('attributes.lastname', capitalize: true),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all(theme.primaryColor),
                  ),
                  onPressed: _submit,
                  child: Text(
                    lang.trans('messages.continue').toUpperCase(),
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: theme.typography.white.button!.color,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
