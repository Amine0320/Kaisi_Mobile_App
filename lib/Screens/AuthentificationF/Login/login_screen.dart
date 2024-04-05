import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kaisi_app/auth/bloc/auth_bloc.dart';
import 'package:kaisi_app/auth/firebase_auth_provider.dart';
import '../../HomeScreen/Components/responsive.dart';
import '../components/background.dart';
import 'components/login_form.dart';
import 'components/login_screen_top_image.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Background(
      child: SingleChildScrollView(
        child: Responsive(
          mobile: const MobileLoginScreen(),
          desktop: Row(
            children: [
              const Expanded(
                child: LoginScreenTopImage(),
              ),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 450,
                      child: BlocProvider<AuthBloc>(
                        create: (context) => AuthBloc(FirebaseAuthProvider()),
                        child: const LoginForm(),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MobileLoginScreen extends StatelessWidget {
  const MobileLoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        const LoginScreenTopImage(),
        Row(
          children: [
            const Spacer(),
            Expanded(
              flex: 8,
              child: BlocProvider<AuthBloc>(
                create: (context) => AuthBloc(FirebaseAuthProvider()),
                child: const LoginForm(),
              ),
            ),
            const Spacer(),
          ],
        ),
      ],
    );
  }
}
