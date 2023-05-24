import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ward/utils/global.dart';
import 'package:ward/utils/theme.dart';

import 'main_home_page/main_home_page.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    print(userId.toString());
    return AnimatedSplashScreen(
      splash: SvgPicture.asset(
        "assets/images/flora_logo.svg",
        color: Colors.white,
      ),
      splashIconSize: 250,
      backgroundColor: mainColor,
      nextScreen: MainHomepage(),
      // userId != 0 && firebaseUser?.displayName == null
      //     ? const MainHomepage()
      //     : const HomeGoogleInfo(),
      splashTransition: SplashTransition.scaleTransition,
    );
  }
}
