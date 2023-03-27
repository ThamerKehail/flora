import 'package:flutter/cupertino.dart';
import 'package:ward/data/repositories/all_places_repository.dart';
import 'package:ward/models/all_places_banner.dart';
import 'package:ward/models/all_places_model.dart';
import '../../../data/repositories/all_places_banner_repository.dart';
import '../../../models/place_details_model.dart';
import '../../../utils/const.dart';
import '../../../utils/location_service.dart';

class AllPlacesViewModel extends ChangeNotifier {
  final AllPlacesRepository allPlacesRepository;
  final AllPlacesBannerRepository allPlacesBannerRepository;

  AllPlacesViewModel(this.allPlacesRepository, this.allPlacesBannerRepository);
  bool isLoading = true;
  String? lat, long, country, adminArea;
  List<PlaceDetailsModel> placesNearMe = [];

  List<String> bannerImg = [];

  String? lat2;
  String? lng;
  double? distanelatlng;
  bool? xy;
  List instantInfo = [];

  Future<List<AllPlaces>>? places;
  Future<List<AllPlacesBannerModel>>? banners;
  List<AllPlaces>? resultBalloons;

  TextEditingController searchTextController = TextEditingController();

  Future<void> getAllPlaces() async {
    isLoading = true;

    places = allPlacesRepository.getAllPlaces();
    resultBalloons = await places;

    notifyListeners();
  }

  void searchForPlaces(String query) async {
    if (query.trim().isEmpty) {
      resultBalloons = await places;
      notifyListeners();
      return;
    }
    resultBalloons = (await places)!.where((place) {
      return place.fname!.startsWith(query);
    }).toList();
    notifyListeners();
  }

  Future<void> getAllBanner() async {
    isLoading = true;
    banners = allPlacesBannerRepository.getAllBanner();
    banners?.then((value) {
      isLoading = false;
      notifyListeners();
    });
    notifyListeners();
  }
  //
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
  //   distanceKm = km;
  // }
}
