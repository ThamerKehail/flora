import 'package:flutter/material.dart';
import 'package:ward/data/repositories/bannar_repository.dart';
import 'package:ward/data/repositories/category_repository.dart';
import 'package:ward/data/repositories/home_image_repository.dart';
import 'package:ward/models/banner.dart';
import 'package:ward/models/category_model.dart';
import 'package:ward/models/home_image.dart';

import '../../../models/place_details_model.dart';

class HomeViewModel extends ChangeNotifier {
  final CategoryRepository categoryRepository;
  final BannerRepository bannerRepository;
  final HomeImageRepository homeImageRepository;
  bool isPageLoading = false;
  void pageLoading() {
    isPageLoading = true;
    notifyListeners();
  }

  // void pageIsLoaded() {
  //   isPageLoading = false;
  //   notifyListeners();
  // }

  HomeViewModel(
    this.categoryRepository,
    this.bannerRepository,
    this.homeImageRepository,
  );
  bool isLoading = true;
  String? lat, long, country, adminArea;

  List<PlaceDetailsModel> placesNearMe = [];
  List<String> bannerImg = [];
  List instantInfo = [];
  String? lat2;
  String? lng;

  Future<List<CategoryModel>>? categories;
  Future<List<BannerModel>>? banners;
  Future<List<HomeImage>>? homeImage;
  final urlImages = [
    'assets/images/ba1.jpg',
    'assets/images/ba2.jpg',
    'assets/images/ba3.jpg',
  ];
  Future<void> getAllCategory() async {
    isLoading = true;
    categories = categoryRepository.getAllCategory();
    categories?.then((value) {
      isLoading = false;
      notifyListeners();
    });
    print("get all data");
    notifyListeners();
  }

  Future<void> getAllBanner() async {
    isLoading = true;
    banners = bannerRepository.getAllBanner();
    banners?.then((value) {
      isLoading = false;
      notifyListeners();
    });
    notifyListeners();
  }

  Future<void> getHomeImage() async {
    isLoading = true;
    homeImage = homeImageRepository.getHomeImage();
    banners?.then((value) {
      isLoading = false;
      notifyListeners();
    });
    notifyListeners();
  }

  bool loading = false;
  // getLocation() async {
  //   loading = true;
  //   notifyListeners();
  //
  //   final service = LocationService();
  //
  //   final locationData = await service.getLocation();
  //   print(await service.checkPermission());
  //   if (await service.checkPermission() != PermissionStatus.deniedForever) {
  //     final placeMark = await service.getPlaceMark(locationData: locationData);
  //     lat = locationData.latitude!.toString();
  //     long = locationData.longitude!.toString();
  //     country = placeMark.country ?? 'could no`t get country ';
  //     adminArea = placeMark.administrativeArea ?? 'could no`t get adminArea ';
  //     //print(await service.checkPermission());
  //
  //     loading = false;
  //     print('locationData ======= $locationData');
  //     print(await service.checkPermission());
  //     SharedPreferences preferences = await SharedPreferences.getInstance();
  //     preferences.setBool('setLocation', true);
  //     isSetLocation = true;
  //   }
  //
  //   notifyListeners();
  // }
  //
  // void alertLocation(BuildContext context) {
  //   showDialog<String>(
  //     context: context,
  //     builder: (BuildContext context) => AlertDialog(
  //       title: const Text('Permeation Location'),
  //       content: const Text(
  //           'Flora App collects location data to enable the identification of nearby Shops even when the app is closed or not in use.'),
  //       actions: <Widget>[
  //         TextButton(
  //           onPressed: () => Navigator.pop(context, 'Cancel'),
  //           child: const Text('Cancel'),
  //         ),
  //         TextButton(
  //           onPressed: () {
  //             getLocation();
  //             Navigator.pop(context);
  //           },
  //           child: const Text('OK'),
  //         ),
  //       ],
  //     ),
  //   );
  // }
  //
  // calDistance(
  //   lat2,
  //   long2,
  // ) async {
  //   const Distance distance = Distance();
  //
  //   // km = 423
  //   final double km = distance.as(LengthUnit.Kilometer,
  //       LatLng(32.003919, 35.858873), LatLng(lat2, long2));
  //
  //   distanceKm = km;
  // }
}
