import 'package:flutter/material.dart';
import 'package:kaisi_app/Screens/Authentification/VerifyEmail/components/Components/verify_from.dart';
import 'package:kaisi_app/Screens/Authentification/VerifyEmail/components/Components/verify_image.dart';
import 'package:kaisi_app/Screens/components/background.dart';
import 'package:kaisi_app/Screens/HomeScreen/Components/responsive.dart';

class VerifyEmailScreen extends StatelessWidget {
  const VerifyEmailScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Background(
      child: SingleChildScrollView(
        child: Responsive(
          mobile: MobileLoginScreen(),
          desktop: Row(
            children: [
              Expanded(
                child: VerifyScreenImage(),
              ),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 450,
                      child: VerifyForm(),
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
  const MobileLoginScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        VerifyScreenImage(),
        Row(
          children: [
            Spacer(),
            Expanded(
              flex: 8,
              child: VerifyForm(),
            ),
            Spacer(),
          ],
        ),
      ],
    );
  }
}
