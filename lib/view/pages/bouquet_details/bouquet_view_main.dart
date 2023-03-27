import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ward/data/repositories/business_color_repository.dart';
import 'package:ward/dio/bouquet_db_helper/bouquet_db_helper.dart';
import 'package:ward/models/bouquet_product_model.dart';
import 'package:ward/models/business_color_model.dart';

import '../../../models/bouquet.dart';

class BouquetViewModel with ChangeNotifier {
  // BouquetDBHelper db = BouquetDBHelper();
  BusinessColorRepository businessColorRepository;
  BouquetViewModel(this.businessColorRepository);
  int _counter = 0;
  int get counter => _counter;
  double _totalPrice = 0.0;
  double get totalPrice => _totalPrice;

  late Future<List<Bouquet>> _bouquet;
  Future<List<Bouquet>> get bouquet => _bouquet;
  List<Bouquet> bouquetResult = [];

  void _setPrefItems() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt('bouquet_item', _counter);
    prefs.setDouble('bouquet_total_price', _totalPrice);
    notifyListeners();
  }

  void _getPrefItems() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _counter = prefs.getInt('bouquet_item') ?? 0;
    _totalPrice = prefs.getDouble('bouquet_total_price') ?? 0.0;
    notifyListeners();
  }

  void addCounter() {
    _counter++;
    _setPrefItems();
    notifyListeners();
  }

  void removeCounter() {
    _counter--;
    _setPrefItems();
    notifyListeners();
  }

  int getCounter() {
    _getPrefItems();
    return _counter;
  }

  void addTotalPrice(double productPrice) {
    _totalPrice = _totalPrice + productPrice;
    _setPrefItems();
    notifyListeners();
  }

  void removeTotalPrice(double productPrice) {
    _totalPrice = _totalPrice - productPrice;
    _setPrefItems();
    notifyListeners();
  }

  double getTotalPrice() {
    _getPrefItems();
    return _totalPrice;
  }

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
