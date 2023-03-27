import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/cart_product_model.dart';
import '../view/pages/home_page/home_view_model.dart';

int userId = 0;
bool isSetLocation = false;
String url = "https://www.florajo.com/uploads";

int? businessIdInCart = 0;
double distanceKm = 0.0;
List<Color> bouquetColor = [];
String statusOrder = "";
int currentColor = 0;
Color bouColor = Colors.white;
// String url = "http://www.florajo.com/assets/images";
List<CartProductModel> allCartProducts = [];

bool messageUser = false;
Future<void> getUserId() async {
  await SharedPreferences.getInstance().then((sharedPrefValue) async {
    userId = await sharedPrefValue.getInt('userId') ?? 0;
  });
}

Future<void> getSetLocation() async {
  await SharedPreferences.getInstance().then((sharedPrefValue) async {
    isSetLocation = await sharedPrefValue.getBool('setLocation') ?? false;
  });
}

Future<void> getBusinessIdInCart() async {
  await SharedPreferences.getInstance().then((sharedPrefValue) async {
    businessIdInCart = await sharedPrefValue.getInt('businessIdInCart');
  });
}
