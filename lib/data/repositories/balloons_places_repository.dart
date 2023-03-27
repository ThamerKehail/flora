import 'package:ward/data/api/balloons_places_api.dart';
import 'package:ward/data/api/flowers_places_api.dart';
import 'package:ward/models/places_model.dart';

import '../../models/all_places_model.dart';
import '../../models/balloons.dart';

class BalloonsPlacesRepository {
  final BalloonsPlacesApi _balloonsPlacesApi;
  BalloonsPlacesRepository(this._balloonsPlacesApi);
  Future<List<AllPlaces>> getAllBalloonsPlaces() {
    return _balloonsPlacesApi.getAllBalloonsPlaces();
  }
}
