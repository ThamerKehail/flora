import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ward/data/repositories/add_to_wishlist_repository.dart';
import 'package:ward/models/wishlist_model.dart';
import '../../../data/repositories/delete_wishlist_item_repository.dart';
import '../../../data/repositories/wishlist_product_repository.dart';
import '../../../models/wishlist_product.dart';

class WishlistViewModel with ChangeNotifier {
  // AddToWishlistRepository addToWishlistRepository;
  // WishlistProductRepository wishlistProductRepository;
  // DeleteWishlistItemRepository deleteWishlistItemRepository;
  // WishlistViewModel(this.addToWishlistRepository,
  //     this.wishlistProductRepository, this.deleteWishlistItemRepository);

  ///New Wishlist view model
  Map<String, WishlistProduct> _item = {};
  Map<String, WishlistProduct> get item {
    return {..._item};
  }

  int get itemCount {
    return _item.length;
  }

  double get totalAmount {
    var total = 0.0;
    _item.forEach((key, WishlistProduct) {
      total += WishlistProduct.productPrice * WishlistProduct.quantity;
    });
    return total;
  }

  void increaseItem({
    required String productId,
    required String image,
    required double productPrice,
    required String productName,
    required int color,
    required int businessId,
    required String message,
  }) {
    _item.update(
        productId,
        (existingCartItem) => WishlistProduct(
              image: existingCartItem.image,
              id: existingCartItem.id,
              productPrice: existingCartItem.productPrice,
              productName: existingCartItem.productName,
              quantity: existingCartItem.quantity + 1,
              color: existingCartItem.color,
              businessId: existingCartItem.businessId,
              message: existingCartItem.message,
              businessEmail: existingCartItem.businessEmail,
            ));
  }

  void decreaseItem({
    required String productId,
    required String image,
    required double productPrice,
    required String productName,
    required int color,
    required int businessId,
    required String message,
  }) {
    if (_item[productId]!.quantity > 1) {
      _item.update(
          productId,
          (existingCartItem) => WishlistProduct(
                image: existingCartItem.image,
                id: existingCartItem.id,
                productPrice: existingCartItem.productPrice,
                productName: existingCartItem.productName,
                quantity: existingCartItem.quantity - 1,
                color: existingCartItem.color,
                businessId: existingCartItem.businessId,
                message: existingCartItem.message,
                businessEmail: existingCartItem.businessEmail,
              ));
    } else {}
  }

  void addWishItem({
    required String productId,
    required String image,
    required double productPrice,
    required String productName,
    required String color,
    required int businessId,
    required String message,
    required String businessEmail,
  }) {
    _item.putIfAbsent(
        productId,
        () => WishlistProduct(
              image: image,
              id: DateTime.now().toString(),
              productPrice: productPrice,
              productName: productName,
              quantity: 1,
              color: color,
              businessId: businessId,
              message: message,
              businessEmail: businessEmail,
            ));
    print(_item);
    notifyListeners();
  }

  void removeWishItem(String productId) {
    _item.remove(productId);
    notifyListeners();
  }

  void removesSingleItem(String productId) {
    if (!_item.containsKey(productId)) {
      return;
    }
    if (_item[productId]!.quantity > 1) {
      _item.update(
          productId,
          (existingCartItem) => WishlistProduct(
                image: existingCartItem.image,
                id: existingCartItem.id,
                productPrice: existingCartItem.productPrice,
                productName: existingCartItem.productName,
                quantity: existingCartItem.quantity - 1,
                color: existingCartItem.color,
                businessId: existingCartItem.businessId,
                message: existingCartItem.message,
                businessEmail: existingCartItem.businessEmail,
              ));
    } else {
      _item.remove(productId);
    }
    notifyListeners();
  }

  void clearWishlist() {
    _item = {};
    notifyListeners();
  }

  //////////////////////////////////////////////////////////////////////////

  // Future<List<Wishlist>> getData() async {
  //   _wishlist = db.getWishList();
  //   wishlistResult = await _wishlist;
  //
  //   return _wishlist;
  // }
  // Future delete({
  //   required int id,
  // }) async {
  //   deleteWishlistItemRepository
  //       .delete(id: id)
  //       .whenComplete(() => getAllWishlistProducts());
  //   notifyListeners();
  // }
  //
  // Future getAllWishlistProducts() async {
  //   wishlistProducts = wishlistProductRepository.getAllWishlistProduct();
  //   wishlistResult = (await wishlistProducts)!;
  //
  //   notifyListeners();
  // }

  // Future addToWishlist({
  //   required int productId,
  // }) async {
  //   addToWishlistRepository.addToWishlist(
  //     productId: productId,
  //   );
  // }

  // void _setPrefItems() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   prefs.setInt('wish_list', _counter);
  //
  //   notifyListeners();
  // }
  //
  // void _getPrefItems() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   _counter = prefs.getInt('wish_list') ?? 0;
  //   notifyListeners();
  // }
  //
  // void addCounter() {
  //   _counter++;
  //   _setPrefItems();
  //   notifyListeners();
  // }
  //
  // void removeCounter() {
  //   _counter--;
  //   _setPrefItems();
  //   notifyListeners();
  // }
  //
  // int getCounter() {
  //   _getPrefItems();
  //   return _counter;
  // }
}
