import 'package:classroom_mobile/l10n/localization.dart';
import 'package:classroom_mobile/widgets/avatar.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class RegisterUserInfo extends StatefulWidget {
  const RegisterUserInfo({Key? key}) : super(key: key);

  @override
  _RegisterUserInfoState createState() => _RegisterUserInfoState();
}

class _RegisterUserInfoState extends State<RegisterUserInfo> {
  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizations.of(context)!;
    final theme = Theme.of(context)!;

    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 41),
        child: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: Text(
                  localization.profileInfo,
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
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all(theme.primaryColor),
                  ),
                  onPressed: null,
                  child: Text(
                    localization.continueMsg.toUpperCase(),
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
