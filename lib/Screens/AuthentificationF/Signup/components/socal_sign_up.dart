import 'package:flutter/material.dart';
import 'package:kaisi_app/Screens/AuthentificationF/Signup/components/or_divider.dart';
import 'package:kaisi_app/Screens/AuthentificationF/Signup/components/social_icon.dart';
import 'package:kaisi_app/auth/auth_exceptions.dart';
import 'package:kaisi_app/auth/auth_service.dart';
import 'package:kaisi_app/utilities/Dialogs/error_dialog.dart';

class SocalSignUp extends StatelessWidget {
  const SocalSignUp({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const OrDivider(),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SocalIcon(
              iconSrc: "assets/icons/google-plus.svg",
              press: () async {
                try {
                  await AuthService.firebase().signInWithGoogle();
                } on GenericAuthException {
                  await showErrorDialog(context, "Échec de l'inscription");
                }
              },
            ),
          ],
        ),
      ],
    );
  }
}
