import 'package:badges/badges.dart' as badge;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ward/utils/theme.dart';
import 'package:ward/view/pages/main_home_page/main_home_view_model.dart';
import 'package:ward/view/pages/wishlist_page/wishlist_view_model.dart';

import '../../pages/cart_page/cart_view_model.dart';

class CustomBottomNavigationBar extends StatefulWidget {
  const CustomBottomNavigationBar({Key? key}) : super(key: key);

  @override
  State<CustomBottomNavigationBar> createState() =>
      _CustomBottomNavigationBarState();
}

class _CustomBottomNavigationBarState extends State<CustomBottomNavigationBar> {
  @override
  Widget build(BuildContext context) {
    final mainHomePageModel = context.watch<MainHomeViewModel>();
    return BottomNavigationBar(
      showSelectedLabels: false,
      showUnselectedLabels: false,
      elevation: 5,
      backgroundColor: Colors.white,
      currentIndex: mainHomePageModel.navIndex(),
      onTap: (index) {
        mainHomePageModel.changeCurrentScreen(index);
      },
      items: [
        BottomNavigationBarItem(
            label: '',
            icon: const Icon(
              Icons.home_outlined,
              size: 30,
              color: Colors.grey,
            ),
            activeIcon: Icon(
              Icons.home,
              size: 35,
              color: mainColor,
            )),
        BottomNavigationBarItem(
          label: '',
          icon: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              badge.Badge(
                badgeStyle: badge.BadgeStyle(
                  badgeColor: mainColor,
                ),
                badgeContent: Consumer<CartViewModel>(
                  builder: (context, value, child) {
                    return Text(
                      value.itemCount.toString(),
                      style: const TextStyle(
                        fontSize: 12,
                        color: Colors.white,
                      ),
                    );
                  },
                ),
                badgeAnimation: badge.BadgeAnimation.slide(
                  disappearanceFadeAnimationDuration:
                      Duration(milliseconds: 300),
                  // curve: Curves.easeInCubic,
                ),
                child: const Icon(
                  Icons.shopping_cart_outlined,
                  size: 30,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
          activeIcon: Icon(
            Icons.shopping_cart,
            size: 35,
            color: mainColor,
          ),
        ),
        BottomNavigationBarItem(
          label: '',
          icon: Icon(
            Icons.person_outline,
            size: 30,
            color: Colors.grey,
          ),
          activeIcon: Icon(
            Icons.person,
            size: 35,
            color: mainColor,
          ),
        ),
      ],
    );
  }
}
