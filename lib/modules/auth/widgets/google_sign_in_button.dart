import 'package:flutter/material.dart';
import 'package:classroom_mobile/lang/lang.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_sign_in/google_sign_in.dart';

class GoogleSignInButton extends StatelessWidget {
  final googleSignin = GoogleSignIn(scopes: [
    'email',
    'profile',
  ]);

  GoogleSignInButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final lang = Lang.of(context);

    return ElevatedButton(
      onPressed: () {
        googleSignin.signIn().then((value) {
          print(value);
        }).catchError(
          (error) {
            print(error);
          },
        );
      },
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
      style: ElevatedButton.styleFrom(
        primary: Colors.black,
        minimumSize: const Size.fromHeight(40.0),
      ),
    );
  }
}
