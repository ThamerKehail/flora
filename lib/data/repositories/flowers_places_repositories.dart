import 'package:ward/data/api/flowers_places_api.dart';
import 'package:ward/models/places_model.dart';

import '../../models/all_places_model.dart';

class FlowersPlacesRepository {
  final BusinessApi _businessApi;
  FlowersPlacesRepository(this._businessApi);
  Future<List<AllPlaces>> getAllFlowersPlaces() {
    return _businessApi.getAllPlaces();
  }
}
