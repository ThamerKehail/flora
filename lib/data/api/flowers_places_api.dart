import '../../dio/dio_client.dart';
import '../../models/all_places_model.dart';
import '../../models/places_model.dart';

class BusinessApi {
  late final DioClient dioClient;
  BusinessApi(this.dioClient);
  Future<List<AllPlaces>> getAllPlaces() async {
    try {
      final response = await dioClient.dio.get('api/flowers_all');
      var data = AllPlaces.asListFromJson(response.data);

      return data;
    } catch (e) {
      print(e);
      return Future.error(e);
    }
  }
}
