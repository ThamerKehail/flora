import '../../dio/dio_client.dart';
import '../../models/all_places_model.dart';
import '../../models/balloons.dart';
import '../../models/flowers_balloons_model.dart';

class FlowersAndBalloonsPlacesApi {
  late final DioClient dioClient;
  FlowersAndBalloonsPlacesApi(this.dioClient);
  Future<List<AllPlaces>> getAllFlowersAndBalloonsPlaces() async {
    try {
      final response = await dioClient.dio.get('api/business_all');
      var data = AllPlaces.asListFromJson(response.data);

      return data;
    } catch (e) {
      print(e);
      return Future.error(e);
    }
  }
}
