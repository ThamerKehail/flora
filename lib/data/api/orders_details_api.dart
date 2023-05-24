import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:ward/utils/routes.dart';

import '../../dio/dio_client.dart';

class OrdersDetailsApi {
  late final DioClient dioClient;
  OrdersDetailsApi(this.dioClient);
  Future orderDetails({
    required List dataList,
    required BuildContext context,
  }) async {
    print(dataList);
    final data = {'order': dataList};
    // {
    //   'userID': userId,
    //   'business_id': businessId,
    //   'payment_method': paymentMethod,
    //   'product_id': productId,
    //   'Qty': qty,
    //   'single_price': '${singlePrice.toDouble()}',
    //   'total_price': totalPrice,
    //   'color': color,
    //   'message': message,
    //   'type': type,
    //   'name': name,
    //   'image': image,
    // };

    Response response;
    response = await dioClient.dio.post('api/order',
        data: FormData.fromMap(data),
        options: Options(headers: {
          'Accept': 'application/json',
          'Content-Type': 'multipart/form-data',
        }));
    print(response.statusCode);
    print(response.data);
    if (response.statusCode == 200) {
      final body = response.data;
      print(body);
      Navigator.pushNamedAndRemoveUntil(
          context, AppRoutes.successScreen, (route) => false);
    } else {
      print(response.statusCode);
      return null!;
    }
  }
}
