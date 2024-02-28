import 'package:flutter/material.dart';
import 'package:kaisi_app/auth/auth_service.dart';
import 'package:kaisi_app/contants/routes.dart';
import 'package:kaisi_app/utilities/show_logout_dialog.dart';
import '../enums/menu_action.dart';

class MainView extends StatefulWidget {
  const MainView({super.key});

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Main UI'),
          // Interface for logout item from popopmenuitem
          actions: [
            PopupMenuButton<MenuAction>(
              onSelected: (value) async {
                switch (value) {
                  case MenuAction.logout:
                    final shouldLogOut = await showLogOutDialog(context);
                    // devtools.log(ShouldLogOut.toString());
                    if (shouldLogOut) {
                      await AuthService.firebase().logOut();
                      Navigator.of(context).pushNamedAndRemoveUntil(
                        loginScreenRoute,
                        (route) => false,
                      );
                    }
                }
              },
              itemBuilder: (context) {
                return const [
                  PopupMenuItem<MenuAction>(
                      value: MenuAction.logout, child: Text('Log Out')),
                ];
              },
            )
          ],
        ),
        body: const Text('Hello World ! '));
  }
}
