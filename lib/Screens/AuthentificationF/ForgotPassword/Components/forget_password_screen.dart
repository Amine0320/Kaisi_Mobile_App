import 'package:flutter/material.dart';
import 'package:kaisi_app/auth/auth_exceptions.dart';
import 'package:kaisi_app/auth/auth_service.dart';
import 'package:kaisi_app/utilities/Dialogs/error_dialog.dart';
import 'package:kaisi_app/utilities/constants/colors.dart';
import 'package:kaisi_app/utilities/constants/routes.dart';

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
            decoration: const InputDecoration(
              hintText: "Votre adresse e-mail",
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
              } on InvalidEmailAuthException {
                showErrorDialog(context,
                    "L'adresse e-mail fournie n'existe pas. Veuillez réessayer.");
              } on UserNotFoundAuthException {
                showErrorDialog(context,
                    "l'utilisateur n'existe pas , veuillez réessayer.");
              } on GenericAuthException {
                showErrorDialog(context, "Erreur, veuillez réessayer.");
              }
            },
            child: Text(
              "Réinitialiser le mot de passe".toUpperCase(),
            ),
          ),
        ],
      ),
    );
  }
}
