import 'package:flutter/material.dart';
import 'package:ward/data/api/address_api.dart';
import 'package:ward/data/api/orders_details_api.dart';

class OrdersDetailsRepository {
  final OrdersDetailsApi _ordersDetailsApi;

  OrdersDetailsRepository(
    this._ordersDetailsApi,
  );
  Future ordersDetails({
    required int businessId,
    required int paymentMethod,
    required int productId,
    required double qty,
    required double singlePrice,
    required double totalPrice,
    required String color,
    required String message,
    required int type,
    required String name,
    required String image,
    required List dataList,
    required BuildContext context,
  }) {
    return _ordersDetailsApi.orderDetails(
      businessId: businessId,
      paymentMethod: paymentMethod,
      productId: productId,
      qty: qty.toDouble(),
      singlePrice: singlePrice,
      totalPrice: totalPrice,
      color: color,
      message: message,
      type: type,
      image: image,
      name: name,
      dataList: dataList,
      context: context,
    );
  }
}
