import 'package:flutter/material.dart';
import 'package:kaisi_app/utilities/constants/routes.dart';

class BackBtnPw extends StatelessWidget {
  const BackBtnPw({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: Tween<Offset>(
        begin: const Offset(-1.0, 0.0),
        end: Offset.zero,
      ).animate(CurvedAnimation(
        parent: ModalRoute.of(context)!.animation!,
        curve: Curves.easeInOut,
      )),
      child: Padding(
        padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
        child: SizedBox(
          height: 58,
          child: Padding(
            padding: const EdgeInsets.only(left: 8, right: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  onPressed: () {
                    Navigator.of(context).pushNamed(loginScreenRoute);
                  },
                  icon: const Icon(Icons.arrow_back_ios_new_rounded),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
