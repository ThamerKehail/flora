class WishlistModel {
  String name;

  double price;
  int businessId;

  String productProfileImg;

  String id;

  WishlistModel({
    required this.name,
    required this.price,
    required this.businessId,
    required this.productProfileImg,
    required this.id,
  });

  WishlistModel.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        price = json['price'].toDouble(),
        businessId = json['business_id'],
        productProfileImg = json['product_profile_img'],
        id = json['id'];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();

    data['name'] = this.name;

    data['price'] = this.price;
    data['business_id'] = this.businessId;

    data['product_profile_img'] = this.productProfileImg;

    data['id'] = this.id;

    return data;
  }

  static List<WishlistModel> asListFromJson(List<dynamic> json) {
    var result = <WishlistModel>[];
    for (var item in json) {
      result.add(WishlistModel.fromJson(item));
    }

    return result;
  }
}
