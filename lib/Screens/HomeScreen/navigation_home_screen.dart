import 'package:flutter/material.dart';
import 'package:kaisi_app/Screens/HomeScreen/home_screen.dart';
import 'package:kaisi_app/Screens/SideBar/Menu/Menu_screen.dart';
import 'package:kaisi_app/Screens/SideBar/Settings/settings_screen.dart';
import 'package:kaisi_app/Screens/SideBar/about_us/aboutus_screen.dart';
import 'package:kaisi_app/Screens/SideBar/feedback/feedback_screen.dart';
import 'package:kaisi_app/Screens/SideBar/Contact/contact_screen.dart';
import 'package:kaisi_app/Screens/SideBar/my_coach/Main/my_coach.dart';
import 'package:kaisi_app/Screens/SideBar/Parrinage/parrinage_screen.dart';
import 'package:kaisi_app/Screens/custom_drawer/drawer_user_controller.dart';
import 'package:kaisi_app/Screens/custom_drawer/home_drawer.dart';
// import 'package:kaisi_app/Screens/HomeScreen/home_screen.dart';
import 'Components/app_theme.dart';

class NavigationHomeScreen extends StatefulWidget {
  const NavigationHomeScreen({super.key});
  @override
  // ignore: library_private_types_in_public_api
  _NavigationHomeScreenState createState() => _NavigationHomeScreenState();
}

class _NavigationHomeScreenState extends State<NavigationHomeScreen> {
  Widget? screenView;
  DrawerIndex? drawerIndex;

  @override
  void initState() {
    drawerIndex = DrawerIndex.home;
    screenView = const MyHomePage();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppTheme.white,
      child: SafeArea(
        top: false,
        bottom: false,
        child: Scaffold(
          backgroundColor: AppTheme.nearlyWhite,
          body: DrawerUserController(
            screenIndex: drawerIndex,
            drawerWidth: MediaQuery.of(context).size.width * 0.75,
            onDrawerCall: (DrawerIndex drawerIndexdata) {
              changeIndex(drawerIndexdata);
              //callback from drawer for replace screen as user need with passing DrawerIndex(Enum index)
            },
            screenView: screenView,
            //we replace screen view as we need on navigate starting screens like MyHomePage, HelpScreen, FeedbackScreen, etc...
          ),
        ),
      ),
    );
  }

  void changeIndex(DrawerIndex drawerIndexdata) {
    if (drawerIndex != drawerIndexdata) {
      drawerIndex = drawerIndexdata;
      switch (drawerIndex) {
        case DrawerIndex.home:
          setState(() {
            screenView = const MyHomePage();
          });
          break;
        case DrawerIndex.menu:
          setState(() {
            screenView = MenuPage();
          });
          break;
        case DrawerIndex.contact:
          setState(() {
            screenView = ContactScreen();
          });
          break;
        case DrawerIndex.feedBack:
          setState(() {
            screenView = FeedbackScreen();
          });
          break;
        case DrawerIndex.invite:
          setState(() {
            screenView = Parrinage();
          });
          break;
        case DrawerIndex.about:
          setState(() {
            screenView = AboutScreen();
          });
          break;
        case DrawerIndex.coach:
          setState(() {
            screenView = const CoachScreen();
          });
          break;
        case DrawerIndex.settings:
          setState(() {
            screenView = const SettingScreen();
          });
          break;
        default:
          break;
      }
    }
  }
}
