import 'package:flutter/material.dart';
import 'package:ward/data/api/address_api.dart';
import 'package:ward/data/api/orders_details_api.dart';

class OrdersDetailsRepository {
  final OrdersDetailsApi _ordersDetailsApi;

  OrdersDetailsRepository(
    this._ordersDetailsApi,
  );
  Future ordersDetails({
    required List dataList,
    required BuildContext context,
  }) {
    return _ordersDetailsApi.orderDetails(
      dataList: dataList,
      context: context,
    );
  }
}
