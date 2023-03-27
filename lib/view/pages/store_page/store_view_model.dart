import 'package:flutter/cupertino.dart';
import 'package:ward/data/repositories/package_repository.dart';
import 'package:ward/models/package_model.dart';
import 'package:ward/models/product_model.dart';

import '../../../data/repositories/avg_business_repository.dart';
import '../../../data/repositories/product_repositories.dart';
import '../../../models/avg_business_rate.dart';

class StoresViewModel extends ChangeNotifier {
  final ProductRepository productRepository;
  final PackageRepository packageRepository;
  final AvgBusinessRepository avgBusinessRepository;

  StoresViewModel(this.productRepository, this.packageRepository,
      this.avgBusinessRepository);
  bool isLoading = true;

  Future<List<Product>>? products;
  Future<List<Package>>? packages;
  Future<AvgBusinessRate>? avg;
  List<AvgBusinessRate> avgRate = [];
  List<Product> allProducts = [];

  Future<void> getAllProduct(int businessId) async {
    isLoading = true;
    products = productRepository.getAllProduct(businessId);
    allProducts = (await products)!;
    allProducts.forEach((element) {
      print(element.name);
    });

    avgRate = await avgRate;
    notifyListeners();
  }

  Future<void> getAvgBusiness(int businessId) async {
    isLoading = true;
    avg = avgBusinessRepository.getAllUsers(businessId);
    notifyListeners();
  }

  Future<void> getAllPackage(int busID) async {
    isLoading = true;
    packages = packageRepository.getAllPackage(busID);
    notifyListeners();
  }
}
