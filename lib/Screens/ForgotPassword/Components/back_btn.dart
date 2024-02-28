import 'package:flutter/material.dart';
import 'package:kaisi_app/contants/routes.dart';

class BackBtnPw extends StatefulWidget {
  const BackBtnPw({Key? key}) : super(key: key);

  @override
  State<BackBtnPw> createState() => _BackBtnPwState();
}

class _BackBtnPwState extends State<BackBtnPw> {
  @override
  Widget build(BuildContext context) {
    return Center(
        child: IconButton(
            icon: Icon(Icons.arrow_back_rounded),
            onPressed: () {
              Navigator.of(context)
                  .pushNamedAndRemoveUntil(loginScreenRoute, (route) => false);
            }));
  }
}
