class Bouquet {
  final String id;

  final String productName;
  final String packageID;

  dynamic productPrice;
  final int quantity;
  final int businessId;
  final String message;
  final String color;
  final String businessEmail;

  final String image;
  Bouquet({
    required this.color,
    required this.message,
    required this.businessId,
    required this.image,
    required this.id,
    required this.productPrice,
    required this.productName,
    required this.quantity,
    required this.businessEmail,
    required this.packageID,
  });
  Bouquet.fromMap(Map<dynamic, dynamic> res)
      : id = res['id'],
        message = res['message'],
        businessId = res['businessId'],
        image = res['image'],
        productPrice = double.parse(res['productPrice'].toString()),
        productName = res['productName'],
        businessEmail = res['businessEmail'],
        packageID = res['package_id'],
        color = res['color'],
        quantity = res['quantity'];
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'image': image,
      'productPrice': productPrice,
      'productName': productName,
      'businessEmail': businessEmail,
      'color': color,
      'package_id': packageID,
      'quantity': quantity,
    };
  }
}
