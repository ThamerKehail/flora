class Bouquet {
  final String id;

  final String productName;

  dynamic productPrice;
  final int quantity;
  final int businessId;
  final String message;

  final String image;
  Bouquet({
    required this.message,
    required this.businessId,
    required this.image,
    required this.id,
    required this.productPrice,
    required this.productName,
    required this.quantity,
  });
  Bouquet.fromMap(Map<dynamic, dynamic> res)
      : id = res['id'],
        message = res['message'],
        businessId = res['businessId'],
        image = res['image'],
        productPrice = double.parse(res['productPrice'].toString()),
        productName = res['productName'],
        quantity = res['quantity'];
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'image': image,
      'productPrice': productPrice,
      'productName': productName,
      'quantity': quantity,
    };
  }
}
