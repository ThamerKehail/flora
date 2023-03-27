import 'package:ward/models/all_places_model.dart';

import '../../dio/dio_client.dart';

class AllPlacesApi {
  late final DioClient dioClient;
  AllPlacesApi(this.dioClient);
  Future<List<AllPlaces>> getAllPlaces() async {
    try {
      final response = await dioClient.dio.get('api/all');
      var data = AllPlaces.asListFromJson(response.data);

      return data;
    } catch (e) {
      print(e);
      return Future.error(e);
    }
  }
}
