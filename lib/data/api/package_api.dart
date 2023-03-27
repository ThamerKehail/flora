import 'package:ward/models/package_model.dart';

import '../../dio/dio_client.dart';

class PackageApi {
  late final DioClient dioClient;
  PackageApi(this.dioClient);
  Future<List<Package>> getAllPackage(int busID) async {
    try {
      final response = await dioClient.dio.get('api/all_package/$busID');

      return Package.asListFromJson(response.data);
    } catch (e) {
      print(e);
      return Future.error(e);
    }
  }
}
