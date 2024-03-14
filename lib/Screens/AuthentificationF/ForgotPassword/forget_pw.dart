import 'package:flutter/material.dart';
import 'package:kaisi_app/Screens/Authentification/ForgotPassword/Components/back_btn.dart';
import 'package:kaisi_app/Screens/Authentification/ForgotPassword/Components/forget_password_screen.dart';
import 'package:kaisi_app/Screens/Authentification/ForgotPassword/Components/forget_pw_image.dart';
import '../../HomeScreen/Components/responsive.dart';
import '../components/background.dart';

class ForgetScreen extends StatelessWidget {
  const ForgetScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Background(
      child: SingleChildScrollView(
        child: Responsive(
          mobile: MobileForgetScreen(),
          desktop: Row(
            children: [
              BackBtnPw(),
              Expanded(
                child: ForgetImage(),
              ),
              // Code added here for the BackBtn !
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: BackBtnPw(),
                ),
              ),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 450,
                      child: ForgetForm(),
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

class MobileForgetScreen extends StatelessWidget {
  const MobileForgetScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        BackBtnPw(),
        ForgetImage(),
        Row(
          children: [
            Spacer(),
            Expanded(
              flex: 8,
              child: ForgetForm(),
            ),
            Spacer(),
          ],
        ),
      ],
    );
  }
}
