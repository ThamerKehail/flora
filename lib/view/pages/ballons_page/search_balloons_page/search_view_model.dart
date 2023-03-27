import 'package:flutter/material.dart';

import '../../../../data/repositories/flowers_places_repositories.dart';
import '../../../../models/all_places_model.dart';
import '../../../../models/places_model.dart';


class PlacesSearchViewModel extends ChangeNotifier {
  final FlowersPlacesRepository businessRepository;

  PlacesSearchViewModel(this.businessRepository);
  bool isLoading = true;

  Future<List<AllPlaces>>? places;
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
}
