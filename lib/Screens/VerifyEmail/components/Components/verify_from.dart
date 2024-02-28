import 'package:flutter/material.dart';
import 'package:kaisi_app/auth/auth_service.dart';
import '../../../../contants/routes.dart';

class VerifyForm extends StatefulWidget {
  const VerifyForm({
    Key? key,
  }) : super(key: key);

  @override
  State<VerifyForm> createState() => _VerifyFormState();
}

class _VerifyFormState extends State<VerifyForm> {
  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        children: [
          const Text(
              "We've already sent you an email of verification. Please open it to verify your account"),
          TextFormField(
            textInputAction: TextInputAction.next,
            cursorColor: kPrimaryColor,
            decoration: const InputDecoration(
              hintStyle:
                  TextStyle(fontWeight: FontWeight.bold), // Make the text bold
              prefixIcon: Padding(
                padding: EdgeInsets.all(defaultPadding),
              ),
            ),
          ),
          const SizedBox(height: defaultPadding),
          ElevatedButton(
            onPressed: () async {
              var sendEmailVerification =
                  AuthService.firebase().sendEmailVerification();
              await sendEmailVerification;
            },
            child: Text(
              "Send Verification Email".toUpperCase(),
            ),
          ),
          const SizedBox(height: defaultPadding),
          ElevatedButton(
            onPressed: () async {
              await AuthService.firebase().logOut();
              Navigator.of(context)
                  .pushNamedAndRemoveUntil(signUpScreenRoute, (route) => false);
            },
            child: Text(
              "Restart".toUpperCase(),
            ),
          ),
        ],
      ),
    );
  }
}
