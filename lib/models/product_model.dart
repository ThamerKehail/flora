import 'cart_model.dart';

class Product {
  late final int productId;
  late final String name;
  late final String nameEr;
  late final String description;
  late final String descriptionEr;
  dynamic price;
  late final int businessId;
  late final int state;
  late final String productProfileImg;
  List<AllProductsBus>? allProductsBus;

  Product(
      {required this.productId,
      required this.name,
      required this.nameEr,
      required this.description,
      required this.descriptionEr,
      required this.price,
      required this.businessId,
      required this.state,
      required this.productProfileImg,
      this.allProductsBus});

  Product.fromJson(Map<String, dynamic> json) {
    productId = json['product_id'];
    name = json['name'];
    nameEr = json['name_er'];
    description = json['description'];
    descriptionEr = json['description_er'];
    price = double.parse(json['price'].toString());
    businessId = json['business_id'];
    state = json['state'];
    productProfileImg = json['product_profile_img'];
    if (json['all__products_bus'] != null) {
      allProductsBus = <AllProductsBus>[];
      json['all__products_bus'].forEach((v) {
        allProductsBus!.add(AllProductsBus.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['product_id'] = productId;
    data['name'] = name;
    data['name_er'] = nameEr;
    data['description'] = description;
    data['description_er'] = descriptionEr;
    data['price'] = price;
    data['business_id'] = businessId;
    data['state'] = state;
    data['product_profile_img'] = productProfileImg;
    if (allProductsBus != null) {
      data['all__products_bus'] =
          allProductsBus!.map((v) => v.toJson()).toList();
    }
    return data;
  }

  static List<Product> asListFromJson(List<dynamic> json) {
    var result = <Product>[];
    for (var item in json) {
      result.add(Product.fromJson(item));
    }
    return result;
  }

  // CartProduct toCartProduct() {
  //   return CartProduct(
  //     productId: productId.toString(),
  //     image: productProfileImg,
  //     id: productId,
  //     productPrice: price,
  //     productName: name,
  //     initialPrice: price,
  //     quantity: 1,
  //     unitTag: 'tag',
  //   );
  // }
}

class AllProductsBus {
  int? color;

  AllProductsBus({this.color});

  AllProductsBus.fromJson(Map<String, dynamic> json) {
    color = json['color'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['color'] = color;
    return data;
  }
}
