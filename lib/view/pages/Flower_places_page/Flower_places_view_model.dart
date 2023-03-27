import 'package:flutter/cupertino.dart';
import 'package:ward/data/repositories/flowers_banner_repository.dart';
import 'package:ward/models/flowers_banners.dart';
import 'package:ward/models/places_model.dart';

import '../../../data/repositories/flowers_places_repositories.dart';
import '../../../models/all_places_model.dart';
import '../../../models/place_details_model.dart';

class FlowerPlacesViewModel extends ChangeNotifier {
  final FlowersPlacesRepository businessRepository;
  final FlowerBannerRepository bannerRepository;

  FlowerPlacesViewModel(this.businessRepository, this.bannerRepository);
  bool isLoading = true;
  List<PlaceDetailsModel> placesNearMe = [];

  List<String> bannerImg = [];
  String? lat, long, country, adminArea;

  String? lat2;
  String? lng;
  double? distanelatlng;
  bool? xy;
  List instantInfo = [];

  Future<List<AllPlaces>>? places;
  Future<List<FlowersBannerModel>>? banners;
  List<AllPlaces>? resultPlaces;

  TextEditingController searchTextController = TextEditingController();

  Future<void> getAllPlaces() async {
    isLoading = true;

    places = businessRepository.getAllFlowersPlaces();
    resultPlaces = await places;

    notifyListeners();
  }

  void searchForPlaces(String query) async {
    if (query.trim().isEmpty) {
      resultPlaces = await places;
      notifyListeners();
      return;
    }
    resultPlaces = (await places)!.where((place) {
      return place.fname!.startsWith(query);
    }).toList();
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

  // void getLocation() async {
  //   final service = LocationService();
  //   final locationData = await service.getLocation();
  //   final placeMark = await service.getPlaceMark(locationData: locationData);
  //   lat = locationData.latitude!.toString();
  //   long = locationData.longitude!.toString();
  //   country = placeMark.country ?? 'could no`t get country ';
  //   adminArea = placeMark.administrativeArea ?? 'could no`t get adminArea ';
  //   notifyListeners();
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
