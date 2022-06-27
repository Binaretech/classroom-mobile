import 'package:classroom_mobile/bloc/authentication/authentication_bloc.dart';
import 'package:classroom_mobile/config/config.dart';
import 'package:classroom_mobile/models/user.dart';
import 'package:classroom_mobile/repository/auth_repository.dart';
import 'package:flutter/material.dart';
import 'package:classroom_mobile/lang/lang.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GoogleSignInButton extends StatelessWidget {
  final googleSignin = GoogleSignIn(
    clientId: Config.googleClientId,
    scopes: ['email', "https://www.googleapis.com/auth/userinfo.profile"],
  );

  final AuthRepository authRepository;

  GoogleSignInButton({Key? key, required this.authRepository})
      : super(key: key);

  void onPressed(BuildContext context) {
    googleSignin.signIn().then((value) async {
      if (value == null) return;

      final auth = await value.authentication;
      final idToken = auth.idToken;

      if (idToken == null) return;

      authRepository.googleSignIn(idToken: idToken).then((value) {
        context
            .read<AuthenticationBloc>()
            .add(AuthenticateUser(value.token.accessToken));

        Navigator.restorablePushNamedAndRemoveUntil(
          context,
          '/',
          (route) => false,
        );
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final lang = Lang.of(context);

    return ElevatedButton(
      onPressed: () => onPressed(context),
      style: ElevatedButton.styleFrom(
        primary: Colors.black,
        minimumSize: const Size.fromHeight(40.0),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: SvgPicture.asset(
              'assets/svg/google.svg',
              height: 20,
              width: 20,
            ),
          ),
          Text(
            lang.trans('messages.loginWithGoogle', capitalize: true),
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
          ),
        ],
      ),
    );
  }
}
