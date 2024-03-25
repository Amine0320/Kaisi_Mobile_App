import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kaisi_app/Screens/AuthentificationF/components/already_have_an_account_acheck.dart';
import 'package:kaisi_app/Screens/SideBar/profile/profile_screen.dart';
import 'package:kaisi_app/auth/auth_exceptions.dart';
import 'package:kaisi_app/auth/auth_service.dart';
import 'package:kaisi_app/utilities/Dialogs/error_dialog.dart';
import 'package:kaisi_app/utilities/constants/routes.dart';
import '../../Login/login_screen.dart';

const double defaultPadding = 16.0;
const Color kPrimaryColor = Colors.blue;

class SignUpForm extends StatefulWidget {
  static SignUpForm get instance => Get.find();
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
  late final TextEditingController _phoneNumberController;

  @override
  void initState() {
    super.initState();
    _firstNameController = TextEditingController();
    _lastNameController = TextEditingController();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _confirmPasswordController = TextEditingController();
    _phoneNumberController = TextEditingController();
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _phoneNumberController.dispose();
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
              hintText: "Prénom",
              prefixIcon: Icon(Icons.person),
            ),
          ),
          TextFormField(
            controller: _lastNameController,
            keyboardType: TextInputType.text,
            textInputAction: TextInputAction.next,
            cursorColor: kPrimaryColor,
            decoration: const InputDecoration(
              hintText: "Nom",
              prefixIcon: Icon(Icons.person),
            ),
          ),
          TextFormField(
            controller: _phoneNumberController, // Assign the controller
            keyboardType: TextInputType.phone, // Set keyboard type to phone
            textInputAction: TextInputAction.done,
            cursorColor: kPrimaryColor,
            decoration: const InputDecoration(
              hintText: "Numéro de téléphone", // Hint text for phone number
              prefixIcon: Icon(Icons.phone), // Phone icon
            ),
          ),
          TextFormField(
            controller: _emailController,
            keyboardType: TextInputType.emailAddress,
            textInputAction: TextInputAction.next,
            cursorColor: kPrimaryColor,
            onSaved: (email) {},
            decoration: const InputDecoration(
              hintText: "Adresse e-mail",
              prefixIcon: Icon(Icons.email),
            ),
          ),
          TextFormField(
            controller: _passwordController,
            textInputAction: TextInputAction.next,
            obscureText: true,
            cursorColor: kPrimaryColor,
            decoration: const InputDecoration(
              hintText: "Mot de passe",
              prefixIcon: Icon(Icons.lock),
            ),
          ),
          TextFormField(
            controller: _confirmPasswordController,
            textInputAction: TextInputAction.done,
            obscureText: true,
            cursorColor: kPrimaryColor,
            decoration: const InputDecoration(
              hintText: "Confirmer le mot de passe",
              prefixIcon: Icon(Icons.lock),
            ),
          ),
          const SizedBox(height: defaultPadding / 2),
          ElevatedButton(
            onPressed: () async {
              final email = _emailController.text;
              final password = _passwordController.text;
              final confirmPassword = _confirmPasswordController.text;
              // Verifying if passwords match or no !
              if (password != confirmPassword) {
                await showErrorDialog(
                    context, 'Les mots de passe ne correspondent pas');
                return;
              }
              // Creating user
              try {
                await AuthService.firebase().createUser(
                  email: email,
                  password: password,
                );
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ProfileScreen(
                      phoneNumber: _phoneNumberController.text,
                      email: _emailController.text,
                      firstname: _firstNameController.text,
                      lastname: _lastNameController.text,
                    ),
                  ),
                );
                // Sending email verificatiom
                await AuthService.firebase().sendEmailVerification();
                // Navigating to verify email view
                Navigator.of(context).pushNamed(verifyEmailScreen);
                // Hnadling exceptions
              } on WeakPasswordAuthException {
                await showErrorDialog(context, 'Mot de passe faible');
              } on EmailAlreadyInUseAuthException {
                await showErrorDialog(context, 'Adresse e-mail déjà utilisée');
              } on InvalidEmailAuthException {
                await showErrorDialog(context, 'Adresse e-mail invalide');
              } on GenericAuthException {
                await showErrorDialog(context, "Échec de l'inscription");
              }
            },
            child: Text("S'inscrire".toUpperCase()),
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
          )
        ],
      ),
    );
  }
}
