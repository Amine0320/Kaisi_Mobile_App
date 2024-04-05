import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kaisi_app/Screens/AuthentificationF/Signup/components/sign_up_top_image.dart';
import 'package:kaisi_app/auth/bloc/auth_bloc.dart';
import 'package:kaisi_app/Screens/AuthentificationF/Signup/components/signup_form.dart';
import 'package:kaisi_app/Screens/AuthentificationF/Signup/components/socal_sign_up.dart';
import 'package:kaisi_app/Screens/AuthentificationF/components/background.dart';
import 'package:kaisi_app/Screens/HomeScreen/Components/responsive.dart';
import 'package:kaisi_app/auth/firebase_auth_provider.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Background(
      child: SingleChildScrollView(
        child: Responsive(
          mobile: const MobileSignupScreen(),
          desktop: Row(
            children: [
              const Expanded(
                child: SignUpScreenTopImage(),
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 450,
                      child: BlocProvider<AuthBloc>(
                        create: (context) => AuthBloc(FirebaseAuthProvider()),
                        child: const SignUpForm(),
                      ),
                    ),
                    const SizedBox(height: defaultPadding / 2),
                    const SocalSignUp()
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class MobileSignupScreen extends StatelessWidget {
  const MobileSignupScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        const SignUpScreenTopImage(),
        Row(
          children: [
            const Spacer(),
            Expanded(
              flex: 8,
              child: BlocProvider<AuthBloc>(
                create: (context) => AuthBloc(FirebaseAuthProvider()),
                child: const SignUpForm(),
              ),
            ),
            const Spacer(),
          ],
        ),
        const SocalSignUp()
      ],
    );
  }
}
