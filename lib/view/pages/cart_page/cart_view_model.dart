import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ward/data/repositories/address_repository.dart';
import 'package:ward/data/repositories/addtocart_repository.dart';

import '../../../data/repositories/cart_product_repository.dart';
import '../../../data/repositories/delete_cart_item_repository.dart';
import '../../../data/repositories/orders_details_repository.dart';
import '../../../data/repositories/send_email_repository.dart';
import '../../../data/repositories/update_qty_repository.dart';
import '../../../models/bouquet.dart';
import '../../../models/cart_model.dart';
import '../../../models/cart_product_model.dart';
import '../../../models/wishlist_product.dart';

class CartViewModel with ChangeNotifier {
  AddressRepository addressRepository;
  OrdersDetailsRepository ordersDetailsRepository;
  AddToCartRepository addToCartRepository;
  SendEmailRepository sendEmailRepository;
  CartProductRepository cartProductRepository;
  DeleteCartItemRepository deleteCartItemRepository;
  UpdateQtyRepository updateQtyRepository;
  CartViewModel(
    this.addressRepository,
    this.ordersDetailsRepository,
    this.sendEmailRepository,
    this.addToCartRepository,
    this.cartProductRepository,
    this.deleteCartItemRepository,
    this.updateQtyRepository,
  );

  //new-cart-view-model
  Map<String, CartProduct> _item = {};
  Map<String, CartProduct> get item {
    return {..._item};
  }

  Map<String, WishlistProduct> _itemWishlist = {};
  Map<String, WishlistProduct> get itemWishlist {
    return {..._itemWishlist};
  }

  Map<String, Bouquet> _bouquetList = {};
  Map<String, Bouquet> get bouquetList {
    return {..._bouquetList};
  }

  void removeWishItem(String productId) {
    _itemWishlist.remove(productId);
    notifyListeners();
  }

  List<Map<String, dynamic>> cartProduct = [];
  void addWishItem({
    required String productId,
    required String image,
    required double productPrice,
    required String productName,
    required String color,
    required int businessId,
    required String message,
  }) {
    _itemWishlist.putIfAbsent(
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
            ));
    print(_item);
    notifyListeners();
  }

  int get itemCount {
    return _item.length;
  }

  int get itemBouquetCount {
    return _bouquetList.length;
  }

  double get totalAmount {
    var total = 0.0;
    _item.forEach((key, CartProduct) {
      total += CartProduct.productPrice * CartProduct.quantity;
    });
    return total;
  }

  double get totalBouquetAmount {
    var total = 0.0;
    _bouquetList.forEach((key, Bouquet) {
      total += Bouquet.productPrice * Bouquet.quantity;
    });
    return total;
  }

  void increaseItem({
    required String productId,
    required String image,
    required double productPrice,
    required String productName,
    required String color,
    required int businessId,
    required String message,
  }) {
    _item.update(
        productId,
        (existingCartItem) => CartProduct(
              image: existingCartItem.image,
              id: existingCartItem.id,
              productPrice: existingCartItem.productPrice,
              productName: existingCartItem.productName,
              quantity: existingCartItem.quantity + 1,
              color: existingCartItem.color,
              businessId: existingCartItem.businessId,
              message: existingCartItem.message,
              productID: existingCartItem.productID,
              businessEmail: existingCartItem.businessEmail,
            ));
    notifyListeners();
  }

  void increaseBouquetItem({
    required String productId,
    required String image,
    required double productPrice,
    required String productName,
  }) {
    _bouquetList.update(
        productId,
        (existingCartItem) => Bouquet(
              image: existingCartItem.image,
              id: existingCartItem.id,
              productPrice: existingCartItem.productPrice,
              productName: existingCartItem.productName,
              quantity: existingCartItem.quantity + 1,
              businessId: existingCartItem.businessId,
              message: existingCartItem.message,
            ));
    notifyListeners();
  }

  void addItem({
    required String productId,
    required String image,
    required double productPrice,
    required String productName,
    required String color,
    required int businessId,
    required String message,
    required String businessEmail,
  }) {
    if (_item.containsKey(productId)) {
      _item.update(
          productId,
          (existingCartItem) => CartProduct(
                image: existingCartItem.image,
                id: existingCartItem.id,
                productPrice: existingCartItem.productPrice,
                productName: existingCartItem.productName,
                quantity: existingCartItem.quantity + 1,
                color: existingCartItem.color,
                businessId: existingCartItem.businessId,
                message: existingCartItem.message,
                productID: existingCartItem.productID,
                businessEmail: existingCartItem.businessEmail,
              ));
      print(_item);
    } else {
      _item.putIfAbsent(
          productId,
          () => CartProduct(
                image: image,
                id: DateTime.now().toString(),
                productPrice: productPrice,
                productName: productName,
                quantity: 1,
                color: color,
                businessId: businessId,
                message: message,
                productID: productId,
                businessEmail: businessEmail,
              ));
      print(_item);
    }
    notifyListeners();
  }

  void addBouquetItem({
    required String productId,
    required String image,
    required double productPrice,
    required String productName,
    required String message,
    required int businessId,
  }) {
    if (_bouquetList.containsKey(productId)) {
      _bouquetList.update(
          productId,
          (existingCartItem) => Bouquet(
                image: existingCartItem.image,
                id: existingCartItem.id,
                productPrice: existingCartItem.productPrice,
                productName: existingCartItem.productName,
                quantity: existingCartItem.quantity + 1,
                businessId: existingCartItem.businessId,
                message: existingCartItem.message,
              ));
      print(_bouquetList);
    } else {
      _bouquetList.putIfAbsent(
          productId,
          () => Bouquet(
                image: image,
                id: DateTime.now().toString(),
                productPrice: productPrice,
                productName: productName,
                quantity: 1,
                businessId: businessId,
                message: message,
              ));
      print(_item);
    }
    notifyListeners();
  }

  void removeItem(String productId) {
    _item.remove(productId);
    notifyListeners();
  }

  void removeBouquetItem(String productId) {
    _bouquetList.remove(productId);
    notifyListeners();
  }

  void removesSingleItem(String productId) {
    if (!_item.containsKey(productId)) {
      return;
    }
    if (_item[productId]!.quantity > 1) {
      _item.update(
          productId,
          (existingCartItem) => CartProduct(
                image: existingCartItem.image,
                id: existingCartItem.id,
                productPrice: existingCartItem.productPrice,
                productName: existingCartItem.productName,
                quantity: existingCartItem.quantity - 1,
                color: existingCartItem.color,
                businessId: existingCartItem.businessId,
                message: existingCartItem.message,
                productID: existingCartItem.productID,
                businessEmail: existingCartItem.businessEmail,
              ));
    } else {
      _item.remove(productId);
    }
    notifyListeners();
  }

  void removesBouquetSingleItem(String productId) {
    if (!_bouquetList.containsKey(productId)) {
      return;
    }
    if (_bouquetList[productId]!.quantity > 1) {
      _bouquetList.update(
          productId,
          (existingCartItem) => Bouquet(
                image: existingCartItem.image,
                id: existingCartItem.id,
                productPrice: existingCartItem.productPrice,
                productName: existingCartItem.productName,
                quantity: existingCartItem.quantity - 1,
                businessId: existingCartItem.businessId,
                message: existingCartItem.message,
              ));
    } else {
      _bouquetList.remove(productId);
    }
    notifyListeners();
  }

  void clear() {
    _item = {};
    notifyListeners();
  }

  void clearBouquet() {
    _bouquetList = {};
    notifyListeners();
  }

////////////////////////////////////////////////////////////////////////////////////
  Future<List<CartProductModel>>? cartProducts;
  List<CartProductModel> allCartProducts = [];
  int currentStep = 0;
  int activeStep = 0; // Initial step set to 5.

  int upperBound = 4;
  int currentStep_ = 0;
  int? businessId;

  // CartDBHelper dbHelper = CartDBHelper();
  TextEditingController city = TextEditingController();
  TextEditingController addressText = TextEditingController();
  TextEditingController street = TextEditingController();
  TextEditingController building = TextEditingController();
  TextEditingController floor = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController note = TextEditingController();
  bool validate = false;
  bool isEmpty = true;
  bool isLoading = true;
  Future getAllCartProducts() async {
    isLoading = true;

    cartProducts = cartProductRepository.getAllCartProduct();
    allCartProducts = (await cartProducts)!;

    notifyListeners();
  }

  Future updateQty({
    required int id,
    required int qty,
  }) async {
    updateQtyRepository
        .updateQty(
          id: id,
          qty: qty,
        )
        .whenComplete(() => getAllCartProducts());
    notifyListeners();
  }

  Future delete({
    required int id,
  }) async {
    deleteCartItemRepository
        .delete(id: id)
        .whenComplete(() => getAllCartProducts());
    notifyListeners();
  }

  bool pageLoading = false;
  Future address({
    required String city,
    required String address,
    required String streetName,
    required int building,
    required int floor,
    required String mobile,
    required String note,
    required int userId,
    required int status,
    required int businessId,
  }) async {
    pageLoading = true;
    notifyListeners();

    addressRepository.address(
      city: city,
      address: address,
      streetName: streetName,
      building: building,
      floor: floor,
      mobile: mobile,
      userId: userId,
      status: status,
      business_id: businessId,
      note: note,
    );
    pageLoading = false;
    notifyListeners();
  }

  Future addToCart({
    required int productId,
    required int businessId,
    required int qty,
  }) async {
    addToCartRepository.addToCart(
      productId: productId,
      businessId: businessId,
      qty: qty,
    );
  }

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
    List? dataList,
    required BuildContext context,
  }) async {
    pageLoading = true;
    notifyListeners();
    ordersDetailsRepository.ordersDetails(
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
      dataList: dataList!,
      context: context,
    );
    pageLoading = false;
    notifyListeners();
  }

  Future sendEmail({
    required String name,
    required String email,
    required String toEmail,
    required String subject,
    required String message,
  }) async {
    sendEmailRepository.sendEmail(
      name: name,
      email: email,
      toEmail: toEmail,
      subject: subject,
      message: message,
    );
  }

  // CartDBHelper db = CartDBHelper();
  int _counter = 0;
  int get counter => _counter;
  double _totalPrice = 0.0;
  double get totalPrice => _totalPrice;

  late Future<List<CartProductModel>> _cart;
  Future<List<CartProductModel>> get cart => _cart;
  List<CartProductModel> cartResult = [];

  Future<List<CartProductModel>> getDataCartProduct() async {
    _cart = cartProductRepository.getAllCartProduct();

    return _cart;
  }

  checkIfExist(int productId) async {
    int index =
        allCartProducts.indexWhere((element) => element.productId == productId);

    return index == -1 ? false : true;
  }

  // Future<bool> checkBuessinessIfExist(String bussId) async {
  //   cartResult = await getData();
  //   int index =
  //       cartResult.indexWhere((element) => element.businessId == bussId);
  //   return index == -1 ? false : true;
  // }

  check(String productID) {
    int index =
        cartResult.indexWhere((element) => element.productId == productID);
    return index == -1 ? false : true;
  }

  checkBusiness(int businessID) {
    int index =
        cartResult.indexWhere((element) => element.businessId == businessID);
    return index == -1 ? false : true;
  }

  // void addToCart(CartProduct cartProduct, int businessID) {
  //   db.insert(cartProduct, businessID);
  // }

  // Future<bool> isProductExists(CartProduct cartProduct) async {
  //   return db.isProductExists(cartProduct);
  // }
  //
  // Future<int> getProductCount(CartProduct cartProduct) async {
  //   return db.getProductCount(cartProduct);
  // }

  Future<int> getCartCount() async {
    return (await _cart).length;
  }

  void _setPrefItems() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt('cart_item', _counter);
    prefs.setDouble('total_price', _totalPrice);
    notifyListeners();
  }

  void _getPrefItems() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _counter = prefs.getInt('cart_item') ?? 0;
    _totalPrice = prefs.getDouble('total_price') ?? 0.0;
    notifyListeners();
  }

  void addCounter() {
    _counter++;
    _setPrefItems();
    notifyListeners();
  }

  void removeAllCounter() {
    _counter = 0;
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

  void removeAllTotalPrice() {
    _totalPrice = 0;
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

  // void storeData({
  //   required String productId,
  //   required String image,
  //   required int id,
  //   required int businessId,
  //   required int color,
  //   required int quantity,
  //   required String productName,
  //   required String unitTag,
  //   required String message,
  //   required double productPrice,
  //   required double initialPrice,
  // }) async {
  //   CartProduct cartProduct = CartProduct(
  //     productId: productId,
  //     image: image,
  //     id: id,
  //     productPrice: productPrice,
  //     productName: productName,
  //     initialPrice: initialPrice,
  //     quantity: quantity,
  //     unitTag: unitTag,
  //     color: color,
  //     businessId: businessId,
  //     message: message,
  //   );
  //   Map<String, dynamic> mapObject = cartProduct.toMap();
  //   String cartData = jsonEncode(mapObject);
  //   List<String> cartDataList = [];
  //   cartDataList.add(cartData);
  //   // print(cartData);
  //
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   prefs.setString('cartData', cartData);
  //
  //   print(prefs.getString('cartData'));
  // }

  getCartData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? cartProduct = prefs.getString('cartData');
    print(cartProduct);

    // SharedPreferences prefs = await SharedPreferences.getInstance();
    // var value = prefs.getString('cartData');
    // CartProduct cartProduct = CartProduct.fromMap(json.decode(value!));
    // print(cartProduct.toMap());
    // return cartProduct.toMap();

    notifyListeners();
  }

  bool loading = false;

  setLoading(bool setLoading) {
    loading = setLoading;
    notifyListeners();
  }
}
