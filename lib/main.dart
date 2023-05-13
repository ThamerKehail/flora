import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:ward/data/api/address_api.dart';
import 'package:ward/data/api/addtocart_api.dart';
import 'package:ward/data/api/all_business_rate.dart';
import 'package:ward/data/api/all_places_api.dart';
import 'package:ward/data/api/all_places_banner_api.dart';
import 'package:ward/data/api/balloons_banner_api.dart';
import 'package:ward/data/api/balloons_places_api.dart';
import 'package:ward/data/api/business_color_api.dart';
import 'package:ward/data/api/business_rated_api.dart';
import 'package:ward/data/api/cart_product_api.dart';
import 'package:ward/data/api/delete_account_api.dart';
import 'package:ward/data/api/edit_password_api.dart';
import 'package:ward/data/api/edit_profile_api.dart';
import 'package:ward/data/api/flowersAndBalloons_places_api.dart';
import 'package:ward/data/api/flowers_places_api.dart';
import 'package:ward/data/api/home_api.dart';
import 'package:ward/data/api/login_api.dart';
import 'package:ward/data/api/orders_api.dart';
import 'package:ward/data/api/orders_details_api.dart';
import 'package:ward/data/api/register_api.dart';
import 'package:ward/data/api/send_email_api.dart';
import 'package:ward/data/api/update_qty_api.dart';
import 'package:ward/data/api/user_api.dart';
import 'package:ward/data/repositories/addtocart_repository.dart';
import 'package:ward/data/repositories/all_business_repository.dart';
import 'package:ward/data/repositories/all_places_banner_repository.dart';
import 'package:ward/data/repositories/all_places_repository.dart';
import 'package:ward/data/repositories/balloons_banners_repository.dart';
import 'package:ward/data/repositories/balloons_places_repository.dart';
import 'package:ward/data/repositories/business_check_repository.dart';
import 'package:ward/data/repositories/delete_account_repository.dart';
import 'package:ward/data/repositories/edit_password_repository.dart';
import 'package:ward/data/repositories/edit_profile_repository.dart';
import 'package:ward/data/repositories/flowers_balloons_places_repository.dart';
import 'package:ward/data/repositories/flowers_banner_repository.dart';
import 'package:ward/data/repositories/flowers_places_repositories.dart';
import 'package:ward/data/repositories/forget_password_repository.dart';
import 'package:ward/data/repositories/home_repository.dart';
import 'package:ward/data/repositories/login_repository.dart';
import 'package:ward/data/repositories/orders_details_repository.dart';
import 'package:ward/data/repositories/orders_repository.dart';
import 'package:ward/data/repositories/rate_repostory.dart';
import 'package:ward/data/repositories/register_repository.dart';
import 'package:ward/data/repositories/send_email_repository.dart';
import 'package:ward/data/repositories/user_repository.dart';
import 'package:ward/dio/dio_client.dart';
import 'package:ward/utils/const.dart';
import 'package:ward/utils/language_constant.dart';
import 'package:ward/utils/router.dart';
import 'package:ward/utils/routes.dart';
import 'package:ward/utils/theme.dart';
import 'package:ward/view/pages/Flower_places_page/Flower_places_view_model.dart';
import 'package:ward/view/pages/Flower_places_page/search_page/search_view_model.dart';
import 'package:ward/view/pages/all_places_page/all_places_view_model.dart';
import 'package:ward/view/pages/ballons_page/balloons_view_model.dart';
import 'package:ward/view/pages/cart_page/cart_view_model.dart';
import 'package:ward/view/pages/edit_password/edit_password_view_model.dart';
import 'package:ward/view/pages/edit_profile/edit_profile_view_model.dart';
import 'package:ward/view/pages/flowers_balloons_page/flowers_balloons_view_model.dart';
import 'package:ward/view/pages/forget_password/forget_password_view_model.dart';
import 'package:ward/view/pages/home_all_data/home_all_data_view_model.dart';
import 'package:ward/view/pages/login_page/google_signIn_provider.dart';
import 'package:ward/view/pages/login_page/login_view_model.dart';
import 'package:ward/view/pages/main_home_page/main_home_view_model.dart';
import 'package:ward/view/pages/order_history_page/order_history_view_model.dart';
import 'package:ward/view/pages/product_details_page/product_details_view_model.dart';
import 'package:ward/view/pages/profile_page/profile_view_model.dart';
import 'package:ward/view/pages/rate_all_business_screen/rate_all_business_view_model.dart';
import 'package:ward/view/pages/register_screen/register_view_model.dart';
import 'package:ward/view/pages/wishlist_page/wishlist_view_model.dart';

import 'data/api/all_user_api.dart';
import 'data/api/business_check_api.dart';
import 'data/api/delete_cart_item_api.dart';
import 'data/api/flower_banner_api.dart';
import 'data/api/flowers_ballons_banner_api.dart';
import 'data/api/forget_password_api.dart';
import 'data/api/rate_api.dart';
import 'data/repositories/address_repository.dart';
import 'data/repositories/all_user_repository.dart';
import 'data/repositories/buisness_rated_repository.dart';
import 'data/repositories/business_color_repository.dart';
import 'data/repositories/cart_product_repository.dart';
import 'data/repositories/delete_cart_item_repository.dart';
import 'data/repositories/flowers_balloons_banners_repository.dart';
import 'data/repositories/update_qty_repository.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  // await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  await getUserId();
  await getSetLocation();
  await getBusinessIdInCart();

  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (_) => WishlistViewModel()),
    ChangeNotifierProvider(
        create: (_) => ProductDetailsViewModel(
            BusinessColorRepository(BusinessColorApi(DioClient())))),
    ChangeNotifierProvider(
        create: (_) => ForgetPasswordViewModel(
            ForgetPasswordRepository(ForgetPasswordApi(DioClient())))),
    ChangeNotifierProvider(
      create: (_) => RegisterViewModel(
          RegisterRepository(RegisterApi(DioClient())),
          AllUserRepository(AllUserApi(DioClient()))),
    ),
    ChangeNotifierProvider(
      create: (_) => HomeAllDataViewModel(HomeRepository(HomeApi(DioClient()))),
    ),
    ChangeNotifierProvider(
      create: (_) => EditPasswordViewModel(
          EditPasswordRepository(EditPasswordApi(DioClient()))),
    ),
    ChangeNotifierProvider(
      create: (_) => OrdersHistoryViewModel(
          OrdersRepository(OrdersApi(DioClient())),
          RateRepository(RateApi(DioClient()))),
    ),
    ChangeNotifierProvider(create: (_) => MainHomeViewModel()),
    ChangeNotifierProvider(
      create: (_) => AllPlacesViewModel(
          AllPlacesRepository(AllPlacesApi(DioClient())),
          AllPlacesBannerRepository(AllPlacesBannerApi(DioClient()))),
    ),
    ChangeNotifierProvider(
      create: (_) => LoginViewModel(LoginRepository(LoginApi(DioClient()))),
    ),
    ChangeNotifierProvider(
      create: (_) => EditProfileViewModel(
          EditProfileRepository(EditProfileApi(DioClient()))),
    ),
    ChangeNotifierProvider(
      create: (_) => CartViewModel(
          AddressRepository(AddressApi(DioClient())),
          OrdersDetailsRepository(OrdersDetailsApi(DioClient())),
          SendEmailRepository(SendEmailApi(DioClientEmail())),
          AddToCartRepository(AddToCartApi(DioClient())),
          CartProductRepository(CartProductApi(DioClient())),
          DeleteCartItemRepository(DeleteCartItemApi(DioClient())),
          UpdateQtyRepository(UpdateQtyApi(DioClient()))),
    ),
    ChangeNotifierProvider(
      create: (_) => ProfileViewModel(UserRepository(UserApi(DioClient())),
          DeleteAccountRepository(DeleteAccountApi(DioClient()))),
    ),
    ChangeNotifierProvider(
      create: (_) => BalloonsPlacesViewModel(
          BalloonsPlacesRepository(BalloonsPlacesApi(DioClient())),
          BalloonsBannerRepository(BalloonsBannerApi(DioClient()))),
    ),
    ChangeNotifierProvider(
        create: (_) => FlowerAndBalloonsPlacesViewModel(
            FlowersAndBalloonsPlacesRepository(
                FlowersAndBalloonsPlacesApi(DioClient())),
            FlowerBalloonsBannerRepository(
                FlowerBalloonsBannerApi(DioClient())))),
    ChangeNotifierProvider(
      create: (_) => PlacesSearchViewModel(
          FlowersPlacesRepository(BusinessApi(DioClient()))),
    ),
    ChangeNotifierProvider(
      create: (_) => RateAllBusinessViewModel(
          AllBusinessRepository(AllBusinessRateApi(DioClient())),
          RateRepository(RateApi(DioClient())),
          CheckBusinessRepository(CheckBusinessApi(DioClient())),
          BusinessRatedRepository(BusinessRatedApi(DioClient()))),
    ),
    ChangeNotifierProvider(
      create: (_) => FlowerPlacesViewModel(
          FlowersPlacesRepository(BusinessApi(DioClient())),
          FlowerBannerRepository(FlowerBannerApi(DioClient()))),
    ),
  ], child: const MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
  static void setLocale(BuildContext context, Locale newLocale) {
    _MyAppState? state = context.findAncestorStateOfType<_MyAppState>();
    state?.setLocale(newLocale);
  }
}

class _MyAppState extends State<MyApp> {
  Locale? _locale;

  setLocale(Locale locale) {
    setState(() {
      _locale = locale;
    });
  }

  @override
  void didChangeDependencies() {
    getLocale().then((local) => setLocale(local));
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (BuildContext context) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Ward',
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          theme: ThemeData(
              primaryColor: mainColor,
              scaffoldBackgroundColor: Colors.white,
              appBarTheme: AppBarTheme(
                color: mainColor,
              )),
          locale: _locale,
          onGenerateRoute: onGenerate,
          initialRoute: AppRoutes.splashScreen,
        );
      },
    );
  }
}
