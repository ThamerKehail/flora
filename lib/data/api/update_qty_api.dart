import 'package:dio/dio.dart';

import '../../dio/dio_client.dart';

class UpdateQtyApi {
  late final DioClient dioClient;
  UpdateQtyApi(this.dioClient);
  Future updateQty({
    required int id,
    required int qty,
  }) async {
    final data = {
      "Qty": qty,
    };
    final dio = Dio();

    Response response;
    response = await dioClient.dio.post(
      'api/updata_qty/$id',
      data: data,
    );
    if (response.statusCode == 200) {
      final body = response.data;
      print(body);
    } else {
      return null!;
    }
  }
}
