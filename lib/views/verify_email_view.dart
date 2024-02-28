import 'package:flutter/material.dart';
import 'package:kaisi_app/auth/auth_service.dart';
import 'package:kaisi_app/contants/routes.dart';

class VerifyEmailView extends StatefulWidget {
  const VerifyEmailView({super.key});

  @override
  State<VerifyEmailView> createState() => _VerifyEmailViewState();
}

class _VerifyEmailViewState extends State<VerifyEmailView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Verify Email')),
      body: Column(
        children: [
          const Text(
              "We've already sent you an email verification . Please open it to verify your account "),
          const Text("If you haven't recieve a verification email"),
          TextButton(
              onPressed: () async {
                var sendEmailVerification =
                    AuthService.firebase().sendEmailVerification();
                await sendEmailVerification;
              },
              child: const Text('send email verification ! ')),
          TextButton(
              onPressed: () async {
                await AuthService.firebase().logOut();
                Navigator.of(context).pushNamedAndRemoveUntil(
                    signUpScreenRoute, (route) => false);
              },
              child: const Text('Restart'))
        ],
      ),
    );
  }
}
