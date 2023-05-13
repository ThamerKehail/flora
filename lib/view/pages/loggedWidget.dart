// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
//
// import '../widget/main_home_widget/bottom_nav_bar_widget.dart';
// import 'main_home_page/main_home_view_model.dart';
//
// class LoggedWidget extends StatelessWidget {
//   LoggedWidget({Key? key}) : super(key: key);
//   final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
//
//   @override
//   Widget build(BuildContext context) {
//     print("yyyyyyyyyyyyyyy");
//     final mainHomePageModel = context.watch<MainHomeViewModel>();
//
//     return Scaffold(
//       body: mainHomePageModel.currentScreen(),
//       bottomNavigationBar: const CustomBottomNavigationBar(),
//     );
//   }
// }
