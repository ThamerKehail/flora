import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ward/view/pages/cart_page.dart';
import 'package:ward/view/pages/home_page/home_page.dart';

import '../../../data/api/bannar_api.dart';
import '../../../data/api/category_api.dart';
import '../../../data/api/home_image_api.dart';
import '../../../data/repositories/bannar_repository.dart';
import '../../../data/repositories/category_repository.dart';
import '../../../data/repositories/home_image_repository.dart';
import '../../../dio/dio_client.dart';
import '../cart_page/cart_page.dart';
import '../home_page/home_view_model.dart';
import '../profile_page/profile_page.dart';

class MainHomeViewModel extends ChangeNotifier {
  // Widget _currentScreen = pages[0];
  int _navigatorIndex = 0;
  final pages = [
    ChangeNotifierProvider<HomeViewModel>(
      create: (_) => HomeViewModel(
          CategoryRepository(
            CategoryApi(DioClient()),
          ),
          BannerRepository(BannerApi(DioClient())),
          HomeImageRepository(HomeImageApi(DioClient()))),
      child: HomePage(),
    ),
    const CartPage(),
    const ProfilePage(),
  ];

  changeCurrentScreen(int index) {
    _navigatorIndex = index;

    notifyListeners();
  }

  int navIndex() {
    return _navigatorIndex;
  }

  currentScreen() {
    return pages[_navigatorIndex];
  }
}
