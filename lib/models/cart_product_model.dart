class CartProductModel {
  int? id;
  int? productId;
  int? userID;
  int? businessId;
  int? qty;
  String? createdAt;
  String? updatedAt;
  String? name;
  String? nameEr;
  String? description;
  String? descriptionEr;
  double? price;
  int? state;
  String? productProfileImg;
  Null? deletedAt;

  CartProductModel(
      {this.id,
      this.productId,
      this.userID,
      this.businessId,
      this.qty,
      this.createdAt,
      this.updatedAt,
      this.name,
      this.nameEr,
      this.description,
      this.descriptionEr,
      this.price,
      this.state,
      this.productProfileImg,
      this.deletedAt});

  CartProductModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    productId = json['product_id'];
    userID = json['userID'];
    businessId = json['business_id'];
    qty = json['Qty'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    name = json['name'];
    nameEr = json['name_er'];
    description = json['description'];
    descriptionEr = json['description_er'];
    price = json['price'].toDouble();
    state = json['state'];
    productProfileImg = json['product_profile_img'];
    deletedAt = json['deleted_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['product_id'] = this.productId;
    data['userID'] = this.userID;
    data['business_id'] = this.businessId;
    data['Qty'] = this.qty;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['name'] = this.name;
    data['name_er'] = this.nameEr;
    data['description'] = this.description;
    data['description_er'] = this.descriptionEr;
    data['price'] = this.price;
    data['state'] = this.state;
    data['product_profile_img'] = this.productProfileImg;
    data['deleted_at'] = this.deletedAt;
    return data;
  }

  static List<CartProductModel> asListFromJson(List<dynamic> json) {
    var result = <CartProductModel>[];
    for (var item in json) {
      result.add(CartProductModel.fromJson(item));
    }
    return result;
  }
}
