import 'package:ward/data/api/orders_api.dart';
import 'package:ward/models/order_history.dart';

class OrdersRepository {
  final OrdersApi _ordersApi;
  OrdersRepository(this._ordersApi);
  Future<List<Orders>> getAllOrder() {
    return _ordersApi.getAllOrders();
  }
}
