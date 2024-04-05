import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:kaisi_app/auth/auth_service.dart';
import 'package:kaisi_app/auth/bloc/auth_bloc.dart';
import 'package:kaisi_app/auth/bloc/auth_event.dart';
import 'package:kaisi_app/utilities/constants/colors.dart';
// import 'package:kaisi_app/utilities/constants/routes.dart';

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
              "Nous vous avons déjà envoyé un e-mail de vérification. Veuillez l'ouvrir pour vérifier votre compte."),
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
              // var sendEmailVerification =
              //     AuthService.firebase().sendEmailVerification();
              // await sendEmailVerification;
              context
                  .read<AuthBloc>()
                  .add(const AuthEvenSendEmailVerification());
            },
            child: Text(
              "Envoyer l'e-mail de vérification".toUpperCase(),
            ),
          ),
          const SizedBox(height: defaultPadding),
          ElevatedButton(
            onPressed: () async {
              // await AuthService.firebase().logOut();
              // Navigator.of(context)
              //     .pushNamedAndRemoveUntil(signUpScreenRoute, (route) => false);
              context.read<AuthBloc>().add(const AuthEventLogOut());
            },
            child: Text(
              "Redémarrer".toUpperCase(),
            ),
          ),
        ],
      ),
    );
  }
}
