import 'package:flutter/material.dart';
import 'package:kaisi_app/Screens/Authentification/ForgotPassword/forget_pw.dart';
import 'package:kaisi_app/Screens/Authentification/Signup/components/signup_form.dart';

class SituationForm extends StatefulWidget {
  const SituationForm({
    Key? key,
  }) : super(key: key);
// MY CODE
  @override
  State<SituationForm> createState() => _LoginViewState();
}

class _LoginViewState extends State<SituationForm> {
  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
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
            cursorColor: kPrimaryColor,
            decoration: const InputDecoration(
              hintText: "adresse e-mail",
              prefixIcon: Padding(
                padding: EdgeInsets.all(defaultPadding),
                child: Icon(Icons.person),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: defaultPadding),
            child: TextFormField(
              controller: _passwordController, // Assign controller
              textInputAction: TextInputAction.done,
              obscureText: true,
              cursorColor: kPrimaryColor,
              decoration: const InputDecoration(
                hintText: "mot de passe",
                prefixIcon: Padding(
                  padding: EdgeInsets.all(defaultPadding),
                  child: Icon(Icons.lock),
                ),
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(
                top: 0.0), // Adjust the top margin as needed
            child: TextButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return const ForgetScreen();
                }));
              },
              child: const Text(''),
            ),
          ),
          ElevatedButton(
            onPressed: () async {},
            child: Text(
              "Suivant".toUpperCase(),
            ),
          ),
          const SizedBox(height: defaultPadding),
        ],
      ),
    );
  }
}
