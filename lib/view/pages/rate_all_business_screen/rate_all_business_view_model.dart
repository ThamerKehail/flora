import 'package:flutter/material.dart';
import 'package:ward/data/repositories/all_business_repository.dart';
import 'package:ward/data/repositories/buisness_rated_repository.dart';
import 'package:ward/data/repositories/orders_repository.dart';
import 'package:ward/models/all_business_rate.dart';
import 'package:ward/models/business_rated_model.dart';
import 'package:ward/models/order_history.dart';

import '../../../data/repositories/business_check_repository.dart';
import '../../../data/repositories/rate_repostory.dart';

class RateAllBusinessViewModel extends ChangeNotifier {
  AllBusinessRepository allBusinessRepository;
  BusinessRatedRepository businessRatedRepository;
  RateRepository rateRepository;
  CheckBusinessRepository checkBusinessRepository;

  RateAllBusinessViewModel(
    this.allBusinessRepository,
    this.rateRepository,
    this.checkBusinessRepository,
    this.businessRatedRepository,
  );
  bool isLoading = true;
  Future<List<AllBusinessRate>>? business;
  Future<List<BusinessRated>>? businessRated;
  Future<void> getAllOrders() async {
    isLoading = true;

    business = allBusinessRepository.getAllBusiness();

    notifyListeners();
  }

  Future<void> getAllBusinessRated() async {
    isLoading = true;

    businessRated = businessRatedRepository.getAllBusiness();

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

  Future checkBusiness({
    required int orderId,
  }) async {
    checkBusinessRepository.checkBusiness(orderId: orderId);
    notifyListeners();
  }
}
