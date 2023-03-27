import 'package:flutter/material.dart';
import 'package:ward/data/repositories/orders_repository.dart';
import 'package:ward/models/order_history.dart';

import '../../../data/repositories/rate_repostory.dart';

class OrdersHistoryViewModel extends ChangeNotifier {
  OrdersRepository ordersRepository;
  RateRepository rateRepository;
  OrdersHistoryViewModel(this.ordersRepository, this.rateRepository);
  bool isLoading = true;
  Future<List<Orders>>? orders;
  Future<void> getAllOrders() async {
    isLoading = true;

    orders = ordersRepository.getAllOrder();

    notifyListeners();
  }

  Future rate({
    required int businessId,
    required int rating,
  }) async {
    rateRepository.rate(
      businessId: businessId,
      rating: rating,
    );
    notifyListeners();
  }
}
