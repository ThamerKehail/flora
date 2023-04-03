import 'package:flutter/material.dart';
import 'package:ward/utils/routes.dart';
import 'package:ward/view/pages/Flower_places_page/Flower_places_page.dart';
import 'package:ward/view/pages/Success_page/successs_page.dart';
import 'package:ward/view/pages/about_us_screen/about_us_screen.dart';
import 'package:ward/view/pages/all_places_page/all_places_page.dart';
import 'package:ward/view/pages/ballons_page/balloons_places_page.dart';
import 'package:ward/view/pages/bouquet_details/bouquet_details.dart';
import 'package:ward/view/pages/cart_page/cart_page.dart';
import 'package:ward/view/pages/edit_password/edit_password.dart';
import 'package:ward/view/pages/home_page/home_page.dart';
import 'package:ward/view/pages/main_home_page/main_home_page.dart';
import 'package:ward/view/pages/order_history_page/order_history_page.dart';
import 'package:ward/view/pages/profile_page/profile_page.dart';
import 'package:ward/view/pages/register_screen/phone_register.dart';
import 'package:ward/view/pages/splash_screen.dart';
import 'package:ward/view/pages/store_page/store_page.dart';

import '../view/pages/flowers_balloons_page/flowers_balloons_page.dart';
import '../view/pages/login_page/login_page.dart';
import '../view/pages/rate_all_business_screen/rate_all_business_screen.dart';
import '../view/pages/wishlist_page/wishlist_page.dart';

Route<dynamic> onGenerate(RouteSettings routeSettings) {
  switch (routeSettings.name) {
    case AppRoutes.successScreen:
      return MaterialPageRoute(builder: (_) => SuccessPage());
    // case AppRoutes.locationPermeationScreen:
    //   return MaterialPageRoute(builder: (_) => LocationPermeationPage());
    case AppRoutes.allRateUsScreen:
      return MaterialPageRoute(builder: (_) => RateAllBusiness());
    case AppRoutes.aboutUsScreen:
      return MaterialPageRoute(builder: (_) => const AboutUsScreen());
    case AppRoutes.editPasswordScreen:
      return MaterialPageRoute(builder: (_) => const EditPassword());
    case AppRoutes.allPlacesScreen:
      return MaterialPageRoute(builder: (_) => const AllPlacesPage());
    case AppRoutes.profileScreen:
      return MaterialPageRoute(builder: (_) => ProfilePage());
    case AppRoutes.orderHistoryScreen:
      return MaterialPageRoute(builder: (_) => const OrderHistory());
    case AppRoutes.phoneRegisterScreen:
      return MaterialPageRoute(builder: (_) => PhoneRegister());
    case AppRoutes.flowersAndBalloonsPlacesScreen:
      return MaterialPageRoute(builder: (_) => const FlowerAndBalloonsPlaces());
    case AppRoutes.balloonsPlacesScreen:
      return MaterialPageRoute(builder: (_) => const BalloonsPlaces());
    case AppRoutes.wishlistScreen:
      return MaterialPageRoute(builder: (_) => const WishlistPage());
    case AppRoutes.cartScreen:
      return MaterialPageRoute(builder: (_) => const CartPage());
    case AppRoutes.bouquetDetailsScreen:
      return MaterialPageRoute(builder: (_) => const BouquetDetails());
    // case AppRoutes.productDetailsScreen:
    //   return MaterialPageRoute(builder: (_) => const ProductDetailsPage());
    case AppRoutes.storeScreen:
      return MaterialPageRoute(
          builder: (_) => StorePage(
                email: '',
              ));
    case AppRoutes.flowersPlacesScreen:
      return MaterialPageRoute(builder: (_) => const FlowerPlaces());
    case AppRoutes.mainHomeScreen:
      return MaterialPageRoute(builder: (_) => const MainHomepage());
    case AppRoutes.homeScreen:
      return MaterialPageRoute(builder: (_) => const HomePage());
    // case AppRoutes.registerScreen:
    //   return MaterialPageRoute(builder: (_) => const RegisterScreen());
    case AppRoutes.loginScreen:
      return MaterialPageRoute(builder: (_) => const LoginPage());
    case AppRoutes.splashScreen:
    default:
      return MaterialPageRoute(builder: (_) => SplashScreen());
  }
}
