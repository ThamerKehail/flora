import 'package:flutter/cupertino.dart';
import 'package:ward/data/repositories/balloons_banners_repository.dart';
import 'package:ward/data/repositories/balloons_places_repository.dart';
import 'package:ward/models/all_places_model.dart';
import 'package:ward/models/balloons_banners.dart';
import '../../../models/balloons.dart';
import '../../../models/place_details_model.dart';

class BalloonsPlacesViewModel extends ChangeNotifier {
  final BalloonsPlacesRepository balloonsPlacesRepository;
  final BalloonsBannerRepository bannerRepository;

  BalloonsPlacesViewModel(this.balloonsPlacesRepository, this.bannerRepository);
  bool isLoading = true;
  List<PlaceDetailsModel> placesNearMe = [];

  List<String> bannerImg = [];
  String? lat, long, country, adminArea;

  String? lat2;
  String? lng;
  double? distanelatlng;
  bool? xy;
  List instantInfo = [];

  Future<List<AllPlaces>>? balloons;
  Future<List<BalloonsBannerModel>>? banners;
  List<AllPlaces>? resultBalloons;

  TextEditingController searchTextController = TextEditingController();

  Future<void> getAllPlaces() async {
    isLoading = true;

    balloons = balloonsPlacesRepository.getAllBalloonsPlaces();
    resultBalloons = await balloons;

    notifyListeners();
  }

  void searchForPlaces(String query) async {
    if (query.trim().isEmpty) {
      resultBalloons = await balloons;
      notifyListeners();
      return;
    }
    resultBalloons = (await balloons)!.where((place) {
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
  //
  // void getLocation() async {
  //   final service = LocationService();
  //   final locationData = await service.getLocation();
  //   final placeMark = await service.getPlaceMark(locationData: locationData);
  //   lat = locationData.latitude!.toString();
  //   long = locationData.longitude!.toString();
  //   country = placeMark.country ?? 'could no`t get country ';
  //   adminArea = placeMark.administrativeArea ?? 'could no`t get adminArea ';
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
  //       LatLng(double.parse(lat!), double.parse(long!)), LatLng(lat2, long2));
  //   distanceKm = km;
  // }
}
