// ignore_for_file: unused_local_variable
import 'package:flutter/material.dart';
import 'package:kaisi_app/Screens/components/already_have_an_account_acheck.dart';
import 'package:kaisi_app/auth/auth_exceptions.dart';
import 'package:kaisi_app/auth/auth_service.dart';
import 'package:kaisi_app/utilities/Dialogs/error_dialog.dart';
import 'package:kaisi_app/utilities/constants/routes.dart';
import '../../Login/login_screen.dart';

const double defaultPadding = 16.0;
const Color kPrimaryColor = Colors.blue;

class SignUpForm extends StatefulWidget {
  const SignUpForm({
    Key? key,
  }) : super(key: key);

  @override
  State<SignUpForm> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<SignUpForm> {
  late final TextEditingController _firstNameController;
  late final TextEditingController _lastNameController;
  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;
  late final TextEditingController _confirmPasswordController;

  @override
  void initState() {
    super.initState();
    _firstNameController = TextEditingController();
    _lastNameController = TextEditingController();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _confirmPasswordController = TextEditingController();
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        children: [
          TextFormField(
            controller: _firstNameController,
            keyboardType: TextInputType.text,
            textInputAction: TextInputAction.next,
            cursorColor: kPrimaryColor,
            decoration: const InputDecoration(
              hintText: "First Name",
              prefixIcon: Icon(Icons.person),
            ),
          ),
          TextFormField(
            controller: _lastNameController,
            keyboardType: TextInputType.text,
            textInputAction: TextInputAction.next,
            cursorColor: kPrimaryColor,
            decoration: const InputDecoration(
              hintText: "Last Name",
              prefixIcon: Icon(Icons.person),
            ),
          ),
          TextFormField(
            controller: _emailController,
            keyboardType: TextInputType.emailAddress,
            textInputAction: TextInputAction.next,
            cursorColor: kPrimaryColor,
            onSaved: (email) {},
            decoration: const InputDecoration(
              hintText: "Your email",
              prefixIcon: Icon(Icons.email),
            ),
          ),
          TextFormField(
            controller: _passwordController,
            textInputAction: TextInputAction.next,
            obscureText: true,
            cursorColor: kPrimaryColor,
            decoration: const InputDecoration(
              hintText: "Your password",
              prefixIcon: Icon(Icons.lock),
            ),
          ),
          TextFormField(
            controller: _confirmPasswordController,
            textInputAction: TextInputAction.done,
            obscureText: true,
            cursorColor: kPrimaryColor,
            decoration: const InputDecoration(
              hintText: "Confirm Password",
              prefixIcon: Icon(Icons.lock),
            ),
          ),
          const SizedBox(height: defaultPadding / 2),
          ElevatedButton(
            onPressed: () async {
              final firstName = _firstNameController.text;
              final lastName = _lastNameController.text;
              final email = _emailController.text;
              final password = _passwordController.text;
              final confirmPassword = _confirmPasswordController.text;
              // Verifying if passwords match or no !
              if (password != confirmPassword) {
                await showErrorDialog(context, 'Passwords do not match');
                return;
              }
              // Creating user
              try {
                await AuthService.firebase().createUser(
                  email: email,
                  password: password,
                );
                // Sending email verificatiom
                await AuthService.firebase().sendEmailVerification();
                // Navigating to verify email view
                Navigator.of(context).pushNamed(verifyEmailScreen);
                // Hnadling exceptions
              } on WeakPasswordAuthException {
                await showErrorDialog(context, 'Weak password');
              } on EmailAlreadyInUseAuthException {
                await showErrorDialog(context, 'Email already in use');
              } on InvalidEmailAuthException {
                await showErrorDialog(context, 'Invalid email address');
              } on GenericAuthException {
                await showErrorDialog(context, "Failed to register");
              }
            },
            child: Text("Sign Up".toUpperCase()),
          ),
          const SizedBox(height: defaultPadding),
          AlreadyHaveAnAccountCheck(
            login: false,
            press: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return const LoginScreen();
                  },
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
