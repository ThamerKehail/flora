class WishlistProduct {
  final String id;

  final String productName;

  double productPrice;
  final int quantity;

  final String image;
  final int businessId;
  final String color;
  final String message;
  WishlistProduct({
    required this.image,
    required this.id,
    required this.productPrice,
    required this.productName,
    required this.quantity,
    required this.color,
    required this.businessId,
    required this.message,
  });
  WishlistProduct.fromMap(Map<String, dynamic> res)
      : id = res['id'],
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
