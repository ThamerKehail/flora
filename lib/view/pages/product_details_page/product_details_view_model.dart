import 'package:flutter/material.dart';
import 'package:ward/data/repositories/business_color_repository.dart';
import 'package:ward/models/business_color_model.dart';

import '../../../utils/const.dart';

class ProductDetailsViewModel extends ChangeNotifier {
  BusinessColorRepository businessColorRepository;
  ProductDetailsViewModel(this.businessColorRepository);
  void changeColor(
      {required int index,
      required Color color,
      required String currentColors}) {
    currentColor = index;

    notifyListeners();
    print(currentColor);
    colorBouq = currentColors;
    print("current Color");
    print(colorBouq);
    notifyListeners();
  }

  String colorBouq = '#ffffff';

  Future<List<BusinessColors>>? colors;
  List<BusinessColors>? colorsList;
  Future<void> getAllColors({required int businessId}) async {
    print("Get Color");
    colors =
        businessColorRepository.getAllBusinessColors(businessId: businessId);
    colorsList = await colors;
    print(colors);

    notifyListeners();
  }
}
