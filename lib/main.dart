import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kaisi_app/Screens/Login/login_screen.dart';
import 'package:kaisi_app/Screens/SideBar/profile/change_name.dart';
import 'package:kaisi_app/Screens/Signup/signup_screen.dart';
import 'package:kaisi_app/Screens/VerifyEmail/components/verify_email_screen.dart';
import 'package:kaisi_app/auth/auth_service.dart';
import 'package:kaisi_app/contants/routes.dart';
import 'package:kaisi_app/controllers/user_controller.dart';
import 'package:kaisi_app/firebase_options.dart';
import 'package:kaisi_app/Screens/introduction_animation/introduction_animation_screen.dart';
import 'package:kaisi_app/Screens/HomeScreen/navigation_home_screen.dart';
import 'Screens/HomeScreen/Components/app_theme.dart';
import 'package:flutter/services.dart';
import 'dart:io';
import 'package:flutter/foundation.dart' show kIsWeb;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  Get.put(UserController());
  Get.testMode = true;
  await SystemChrome.setPreferredOrientations(<DeviceOrientation>[
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown
  ]).then((_) => runApp(MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
      statusBarBrightness:
          !kIsWeb && Platform.isAndroid ? Brightness.dark : Brightness.light,
      systemNavigationBarColor: Colors.white,
      systemNavigationBarDividerColor: Colors.transparent,
      systemNavigationBarIconBrightness: Brightness.dark,
    ));
    return MaterialApp(
      title: 'KAISI APPLICATION',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        textTheme: AppTheme.textTheme,
        platform: TargetPlatform.iOS,
      ),
      home: const HomePage(),
      routes: {
        loginScreenRoute: (context) => const LoginScreen(),
        signUpScreenRoute: (context) => const SignUpScreen(),
        verifyEmailScreen: (context) => const VerifyEmailScreen(),
        navigationRoute: (context) => const NavigationHomeScreen(),
        changeNameRoute: (context) => const ChangeName(),
      },
    );
  }
}

// CLASS HEX COLOR
class HexColor extends Color {
  HexColor(final String hexColor) : super(_getColorFromHex(hexColor));

  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll('#', '');
    if (hexColor.length == 6) {
      hexColor = 'FF' + hexColor;
    }
    return int.parse(hexColor, radix: 16);
  }
}

// CLASS HOME PAGE HERE ! (Logically right)
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: AuthService.firebase().intialize(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          // Loading indicator while initializing
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (snapshot.hasError) {
          // Error handling for initialization
          return const Center(
            child: Text('Error'),
          );
        } else {
          final user = AuthService.firebase().currentUser;
          if (user != null) {
            // If user is authenticated, navigate to home screen
            return const NavigationHomeScreen();
          } else {
            // If user is not authenticated, show introduction screen
            return const IntroductionAnimationScreen();
          }
        }
      },
    );
  }
}
