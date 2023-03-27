import 'package:dio/dio.dart';

import '../../dio/dio_client.dart';

class DeleteWishlistItemApi {
  late final DioClient dioClient;
  DeleteWishlistItemApi(this.dioClient);
  Future delete({
    required int id,
  }) async {
    final data = {};
    final dio = Dio();

    Response response;
    response = await dioClient.dio.post(
      'api/delete_wish/$id',
    );
    if (response.statusCode == 200) {
      final body = response.data;
      print(body);
    } else {
      return null!;
    }
  }
}
