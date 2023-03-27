import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../../dio/dio_client.dart';
import '../../utils/const.dart';

class AddToCartApi {
  late final DioClient dioClient;
  AddToCartApi(this.dioClient);
  Future addToCart({
    required int productId,
    required int businessId,
    required int qty,
  }) async {
    final data = {
      'userID': "$userId",
      'product_id': '$productId',
      'business_id': '$businessId',
      'Qty': qty,
    };
    final dio = Dio();

    Response response;
    response = await dioClient.dio.post('api/cart', data: data);
    if (response.statusCode == 200) {
      final body = response.data;
      print(body);
    } else {
      return null!;
    }
  }
}
