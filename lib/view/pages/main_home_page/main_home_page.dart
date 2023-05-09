import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ward/utils/alert_exit_app.dart';
import 'package:ward/utils/const.dart';
import 'package:ward/view/pages/main_home_page/main_home_view_model.dart';

import '../../widget/main_home_widget/bottom_nav_bar_widget.dart';
import '../profile_page/profile_view_model.dart';

class MainHomepage extends StatefulWidget {
  const MainHomepage({Key? key}) : super(key: key);

  @override
  State<MainHomepage> createState() => _MainHomepageState();
}

class _MainHomepageState extends State<MainHomepage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUserId();
    Future.microtask(() => context.read<ProfileViewModel>().getUserInfo());
  }

  @override
  Widget build(BuildContext context) {
    print("///////$userId//////////");
    final mainHomePageModel = context.watch<MainHomeViewModel>();

    return Scaffold(
      body: WillPopScope(
        onWillPop: () => showExitPopup(context),
        child: IndexedStack(
          index: mainHomePageModel.navIndex(),
          children: mainHomePageModel.pages,
        ),
      ),
      bottomNavigationBar: const CustomBottomNavigationBar(),
    );
  }
}
