import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ward/utils/const.dart';
import 'package:ward/utils/theme.dart';
import 'package:ward/view/pages/location_permeation_page/location_permation_page.dart';
import 'package:ward/view/pages/main_home_page/main_home_page.dart';
import 'package:ward/view/pages/profile_page/profile_view_model.dart';

import 'Flower_places_page/Flower_places_view_model.dart';
import 'all_places_page/all_places_view_model.dart';
import 'ballons_page/balloons_view_model.dart';
import 'google_info.dart';
import 'home_page/home_view_model.dart';
import 'login_page/login_page.dart';

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
