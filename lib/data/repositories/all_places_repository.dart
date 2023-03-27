import 'package:ward/data/api/all_places_api.dart';
import 'package:ward/models/all_places_model.dart';

class AllPlacesRepository {
  final AllPlacesApi _allPlacesApi;
  AllPlacesRepository(this._allPlacesApi);
  Future<List<AllPlaces>> getAllPlaces() {
    return _allPlacesApi.getAllPlaces();
  }
}
