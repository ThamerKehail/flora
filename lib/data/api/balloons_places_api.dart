import '../../dio/dio_client.dart';
import '../../models/all_places_model.dart';
import '../../models/balloons.dart';
import '../../models/places_model.dart';

class BalloonsPlacesApi {
  late final DioClient dioClient;
  BalloonsPlacesApi(this.dioClient);
  Future<List<AllPlaces>> getAllBalloonsPlaces() async {
    try {
      final response = await dioClient.dio.get('api/balloons_all');
      var data = AllPlaces.asListFromJson(response.data);

      return data;
    } catch (e) {
      print(e);
      return Future.error(e);
    }
  }
}
