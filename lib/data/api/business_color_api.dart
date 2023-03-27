import 'package:ward/dio/dio_client.dart';
import 'package:ward/models/business_color_model.dart';

class BusinessColorApi {
  late final DioClient dioClient;
  BusinessColorApi(this.dioClient);
  Future<List<BusinessColors>> getAllBusinessColors(
      {required String businessId}) async {
    try {
      final response = await dioClient.dio.get('api/all_color/${businessId}');
      var data = BusinessColors.asListFromJson(response.data);
      print("all color =$data");
      return data;
    } catch (e) {
      print(e);
      return Future.error(e);
    }
  }
}
