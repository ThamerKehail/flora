import 'package:ward/data/api/flowersAndBalloons_places_api.dart';
import 'package:ward/models/flowers_balloons_model.dart';

import '../../models/all_places_model.dart';

class FlowersAndBalloonsPlacesRepository {
  final FlowersAndBalloonsPlacesApi _flowersAndBalloonsPlacesApi;
  FlowersAndBalloonsPlacesRepository(this._flowersAndBalloonsPlacesApi);
  Future<List<AllPlaces>> getAllFlowersAndBalloonsPlaces() {
    return _flowersAndBalloonsPlacesApi.getAllFlowersAndBalloonsPlaces();
  }
}
