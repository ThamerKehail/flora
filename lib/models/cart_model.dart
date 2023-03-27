class CartProduct {
  final String id;

  final String productName;
  final String productID;
  double productPrice;
  final double quantity;

  final String image;
  final int businessId;
  final String color;
  final String message;
  final String businessEmail;
  CartProduct({
    required this.productID,
    required this.image,
    required this.id,
    required this.productPrice,
    required this.productName,
    required this.quantity,
    required this.color,
    required this.businessId,
    required this.message,
    required this.businessEmail,
  });
  CartProduct.fromMap(Map<String, dynamic> res)
      : id = res['id'],
        businessEmail = res['businessEmail'],
        productID = res['productID'],
        image = res['image'],
        productPrice = double.parse(res['productPrice'].toString()),
        productName = res['productName'],
        quantity = res['quantity'],
        color = res['color'],
        businessId = res['businessId'],
        message = res['message'];
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'image': image,
      'productPrice': productPrice,
      'productName': productName,
      'quantity': quantity,
      'color': color,
      'businessId': businessId,
      'message': message,
    };
  }
}
