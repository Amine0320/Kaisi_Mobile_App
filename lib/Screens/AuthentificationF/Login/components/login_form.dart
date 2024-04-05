import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kaisi_app/Screens/AuthentificationF/ForgotPassword/forget_pw.dart';
import 'package:kaisi_app/Screens/AuthentificationF/Signup/signup_screen.dart';
import 'package:kaisi_app/Screens/AuthentificationF/components/already_have_an_account_acheck.dart';
import 'package:kaisi_app/Screens/popups/full_screen_loader.dart';
import 'package:kaisi_app/Screens/popups/loaders.dart';
// import 'package:kaisi_app/Screens/popups/full_screen_loader.dart';
import 'package:kaisi_app/auth/auth_exceptions.dart';
// import 'package:kaisi_app/auth/auth_service.dart';
import 'package:kaisi_app/auth/bloc/auth_bloc.dart';
import 'package:kaisi_app/auth/bloc/auth_event.dart';
import 'package:kaisi_app/auth/bloc/auth_state.dart';
import 'package:kaisi_app/utilities/Dialogs/error_dialog.dart';
import 'package:kaisi_app/utilities/constants/colors.dart';
// import 'package:kaisi_app/utilities/constants/routes.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({
    Key? key,
  }) : super(key: key);
// MY CODE
  @override
  State<LoginForm> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginForm> {
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
    return BlocListener<AuthBloc, AuthState>(
        listener: (context, state) async {
          if (state is AuthStateLoggedOut) {
            // final closeDialog = _closeDialogHandler;
            // closing dialog
            // try {
            //   if (!state.isLoading) {
            //     TFullScreenLoader.stopLoading();
            //     return;
            //   }
            //   // open dialog
            //   if (state.isLoading) {
            //     TFullScreenLoader.openLoadingDialog(
            //       'Logging you in...',
            //       'assets/animation/141594-animation-of-docer.json',
            //     );
            //   }
            // } catch (e) {
            //   TFullScreenLoader.stopLoading();
            //   TLoaders.errorSnackBar(title: 'Oh Snap', message: e.toString());
            // }
            if (state.exception is UserNotFoundAuthException ||
                state.exception is WrongPasswordAuthException) {
              await showErrorDialog(context, 'User-not-found');
            }
            // else if (state.exception is WrongPasswordAuthException) {
            //   await showErrorDialog(context, 'Wrong crendetials');
            // }
            else if (state.exception is GenericAuthException) {
              await showErrorDialog(context, 'Authentification Error');
            }
          }
        },
        child: Form(
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
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return const ForgetScreen();
                    }));
                  },
                  child: const Text('Réinitialiser le mot de passe'),
                ),
              ),
              ElevatedButton(
                onPressed: () async {
                  final email = _emailController.text;
                  final password = _passwordController.text;

                  // try {
                  //   await AuthService.firebase().logIn(
                  //     email: email,
                  //     password: password,
                  //   );
                  context.read<AuthBloc>().add(AuthEventLogIn(
                        email,
                        password,
                      ));
                  // Logic will be back when resolve sendemailverification problem ! HERE !
                  //     final user = AuthService.firebase().currentUser;
                  //     if (user?.isEmailVerified ?? false) {
                  //       Navigator.of(context).pushNamedAndRemoveUntil(
                  //         navigationRoute,
                  //         (route) => false,
                  //       );
                  //     } else {
                  //       Navigator.of(context).pushNamedAndRemoveUntil(
                  //         verifyEmailScreen,
                  //         (route) => false,
                  //       );
                  //     }
                  //     Navigator.of(context).pushNamed(navigationRoute);
                  //   } on UserNotFoundAuthException {
                  //     await showErrorDialog(context, 'Utilisateur non trouvé');
                  //   } on WrongPasswordAuthException {
                  //     await showErrorDialog(context, 'Mauvais mot de passe');
                  //   } on GenericAuthException {
                  //     await showErrorDialog(context, "Erreur d'authentification");
                  //   }
                },
                child: Text(
                  "Se connecter".toUpperCase(),
                ),
              ),
              const SizedBox(height: defaultPadding),
              AlreadyHaveAnAccountCheck(
                press: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return const SignUpScreen();
                      },
                    ),
                  );
                },
              ),
            ],
          ),
        ));
  }
}
