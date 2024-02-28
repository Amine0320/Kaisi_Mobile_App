import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kaisi_app/auth/auth_service.dart';
import 'package:kaisi_app/contants/routes.dart';
import 'package:kaisi_app/utilities/show_error_log.dart';

class ForgetForm extends StatefulWidget {
  const ForgetForm({Key? key}) : super(key: key);

  @override
  State<ForgetForm> createState() => _ForgetFormState();
}

class _ForgetFormState extends State<ForgetForm> {
  late final TextEditingController _emailController;

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
  }

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        children: [
          TextFormField(
            controller: _emailController,
            keyboardType: TextInputType.emailAddress,
            textInputAction: TextInputAction.next,
            cursorColor: kPrimaryColor, // Assuming kPrimaryColor is defined
            decoration: InputDecoration(
              hintText: "Your email",
              prefixIcon: Padding(
                padding: EdgeInsets.all(
                    defaultPadding), // Assuming defaultPadding is defined
                child: Icon(Icons.email),
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () async {
              try {
                await AuthService.firebase()
                    .resetPassword(_emailController.text);
                await Future.delayed(const Duration(seconds: 4));
                Navigator.of(context).pushNamedAndRemoveUntil(
                    loginScreenRoute, (route) => false);
              } on FirebaseAuthException {
                showErrorDialog(
                    context, "Email provided doesn't exist Try again");
              }
            },
            child: Text(
              "Reset Password".toUpperCase(),
            ),
          ),
        ],
      ),
    );
  }
}
