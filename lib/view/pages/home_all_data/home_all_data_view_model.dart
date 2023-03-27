import 'package:flutter/material.dart';
import 'package:ward/data/repositories/home_repository.dart';
import 'package:ward/models/home_model.dart';

class HomeAllDataViewModel extends ChangeNotifier {
  HomeRepository homeRepository;
  HomeAllDataViewModel(this.homeRepository);
  Future<List<HomeModel>>? home;
  bool isLoading = true;
  Future<void> getHomeData() async {
    isLoading = true;

    home = homeRepository.getAllBusiness();

    notifyListeners();
  }
}
