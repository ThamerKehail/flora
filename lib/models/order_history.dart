// class Orders {
//   int? id;
//   int? orderId;
//   int? businessId;
//   int? userID;
//   int? paymentMethod;
//   int? productId;
//   int? qty;
//   dynamic singlePrice;
//   dynamic totalPrice;
//   dynamic? color;
//   String? image;
//   String? name;
//   String? message;
//   dynamic? type;
//   String? createdAt;
//   String? updatedAt;
//   List<OrdersAddres>? ordersAddres;
//
//   Orders(
//       {this.id,
//       this.orderId,
//       this.businessId,
//       this.userID,
//       this.paymentMethod,
//       this.productId,
//       this.qty,
//       this.singlePrice,
//       this.totalPrice,
//       this.color,
//       this.image,
//       this.name,
//       this.message,
//       this.type,
//       this.createdAt,
//       this.updatedAt,
//       this.ordersAddres});
//
//   Orders.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     orderId = json['order_id'];
//     businessId = json['business_id'];
//     userID = json['userID'];
//     paymentMethod = json['payment_method'];
//     productId = json['product_id'];
//     qty = json['Qty'];
//     singlePrice = json['single_price'].toDouble();
//     totalPrice = json['total_price'].toDouble();
//     color = json['color'];
//     image = json['image'];
//     name = json['name'];
//     message = json['message'];
//     type = json['type'];
//     createdAt = json['created_at'];
//     updatedAt = json['updated_at'];
//     if (json['orders_addres'] != null) {
//       ordersAddres = <OrdersAddres>[];
//       json['orders_addres'].forEach((v) {
//         ordersAddres!.add(new OrdersAddres.fromJson(v));
//       });
//     }
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['order_id'] = this.orderId;
//     data['business_id'] = this.businessId;
//     data['userID'] = this.userID;
//     data['payment_method'] = this.paymentMethod;
//     data['product_id'] = this.productId;
//     data['Qty'] = this.qty;
//     data['single_price'] = this.singlePrice;
//     data['total_price'] = this.totalPrice;
//     data['color'] = this.color;
//     data['image'] = this.image;
//     data['name'] = this.name;
//     data['message'] = this.message;
//     data['type'] = this.type;
//     data['created_at'] = this.createdAt;
//     data['updated_at'] = this.updatedAt;
//     if (this.ordersAddres != null) {
//       data['orders_addres'] =
//           this.ordersAddres!.map((v) => v.toJson()).toList();
//     }
//     return data;
//   }
//
//   static List<Orders> asListFromJson(List<dynamic> json) {
//     var result = <Orders>[];
//     for (var item in json) {
//       result.add(Orders.fromJson(item));
//     }
//
//     return result;
//   }
// }
//
// class OrdersAddres {
//   int? orderId;
//   String? city;
//   String? address;
//   String? strretName;
//   int? building;
//   int? floor;
//   String? mobile;
//   int? userId;
//   int? businessId;
//   int? status;
//
//   OrdersAddres(
//       {this.orderId,
//       this.city,
//       this.address,
//       this.strretName,
//       this.building,
//       this.floor,
//       this.mobile,
//       this.userId,
//       this.businessId,
//       this.status});
//
//   OrdersAddres.fromJson(Map<String, dynamic> json) {
//     orderId = json['order_id'];
//     city = json['city'];
//     address = json['address'];
//     strretName = json['strret_name'];
//     building = json['building'];
//     floor = json['floor'];
//     mobile = json['mobile'];
//     userId = json['user_id'];
//     businessId = json['business_id'];
//     status = json['status'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['order_id'] = this.orderId;
//     data['city'] = this.city;
//     data['address'] = this.address;
//     data['strret_name'] = this.strretName;
//     data['building'] = this.building;
//     data['floor'] = this.floor;
//     data['mobile'] = this.mobile;
//     data['user_id'] = this.userId;
//     data['business_id'] = this.businessId;
//     data['status'] = this.status;
//     return data;
//   }
// }
class Orders {
  int? id;
  int? orderId;
  int? businessId;
  int? userID;
  int? paymentMethod;
  int? productId;
  int? packageId;
  int? qty;
  int? singlePrice;
  double? totalPrice;
  String? color;
  String? image;
  String? name;
  String? message;
  String? type;
  String? createdAt;
  String? updatedAt;
  List<OrdersAddres>? ordersAddres;
  List<ProductDetail>? productDetail;
  List<PackageDetail>? packegeDetail;

  Orders(
      {this.id,
      this.orderId,
      this.businessId,
      this.userID,
      this.paymentMethod,
      this.productId,
      this.packageId,
      this.qty,
      this.singlePrice,
      this.totalPrice,
      this.color,
      this.image,
      this.name,
      this.message,
      this.type,
      this.createdAt,
      this.updatedAt,
      this.ordersAddres,
      this.productDetail,
      this.packegeDetail});

  Orders.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    orderId = json['order_id'];
    businessId = json['business_id'];
    userID = json['userID'];
    paymentMethod = json['payment_method'];
    productId = json['product_id'];
    packageId = json['package_id'];
    qty = json['Qty'];
    singlePrice = json['single_price'];
    totalPrice = json['total_price'];
    color = json['color'];
    image = json['image'];
    name = json['name'];
    message = json['message'];
    type = json['type'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    if (json['orders_addres'] != null) {
      ordersAddres = <OrdersAddres>[];
      json['orders_addres'].forEach((v) {
        ordersAddres!.add(new OrdersAddres.fromJson(v));
      });
    }
    if (json['product_detail'] != null) {
      productDetail = <ProductDetail>[];
      json['product_detail'].forEach((v) {
        productDetail!.add(new ProductDetail.fromJson(v));
      });
    }
    if (json['packege_detail'] != null) {
      packegeDetail = <PackageDetail>[];
      json['packege_detail'].forEach((v) {
        packegeDetail!.add(PackageDetail.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['order_id'] = this.orderId;
    data['business_id'] = this.businessId;
    data['userID'] = this.userID;
    data['payment_method'] = this.paymentMethod;
    data['product_id'] = this.productId;
    data['package_id'] = this.packageId;
    data['Qty'] = this.qty;
    data['single_price'] = this.singlePrice;
    data['total_price'] = this.totalPrice;
    data['color'] = this.color;
    data['image'] = this.image;
    data['name'] = this.name;
    data['message'] = this.message;
    data['type'] = this.type;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.ordersAddres != null) {
      data['orders_addres'] =
          this.ordersAddres!.map((v) => v.toJson()).toList();
    }
    if (this.productDetail != null) {
      data['product_detail'] =
          this.productDetail!.map((v) => v.toJson()).toList();
    }
    if (this.packegeDetail != null) {
      data['packege_detail'] =
          this.packegeDetail!.map((v) => v!.toJson()).toList();
    }
    return data;
  }

  static List<Orders> asListFromJson(List<dynamic> json) {
    var result = <Orders>[];
    for (var item in json) {
      result.add(Orders.fromJson(item));
    }
    return result;
  }
}

class OrdersAddres {
  int? orderId;
  String? city;
  String? address;
  String? strretName;
  int? building;
  int? floor;
  String? mobile;
  int? userId;
  int? businessId;
  int? status;

  OrdersAddres(
      {this.orderId,
      this.city,
      this.address,
      this.strretName,
      this.building,
      this.floor,
      this.mobile,
      this.userId,
      this.businessId,
      this.status});

  OrdersAddres.fromJson(Map<String, dynamic> json) {
    orderId = json['order_id'];
    city = json['city'];
    address = json['address'];
    strretName = json['strret_name'];
    building = json['building'];
    floor = json['floor'];
    mobile = json['mobile'];
    userId = json['user_id'];
    businessId = json['business_id'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['order_id'] = this.orderId;
    data['city'] = this.city;
    data['address'] = this.address;
    data['strret_name'] = this.strretName;
    data['building'] = this.building;
    data['floor'] = this.floor;
    data['mobile'] = this.mobile;
    data['user_id'] = this.userId;
    data['business_id'] = this.businessId;
    data['status'] = this.status;
    return data;
  }
}

class ProductDetail {
  int? productId;
  String? name;
  String? nameEr;
  String? description;
  String? descriptionEr;
  double? price;
  int? businessId;
  int? state;
  String? productProfileImg;

  ProductDetail(
      {this.productId,
      this.name,
      this.nameEr,
      this.description,
      this.descriptionEr,
      this.price,
      this.businessId,
      this.state,
      this.productProfileImg});

  ProductDetail.fromJson(Map<String, dynamic> json) {
    productId = json['product_id'];
    name = json['name'];
    nameEr = json['name_er'];
    description = json['description'];
    descriptionEr = json['description_er'];
    price = json['price'];
    businessId = json['business_id'];
    state = json['state'];
    productProfileImg = json['product_profile_img'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['product_id'] = this.productId;
    data['name'] = this.name;
    data['name_er'] = this.nameEr;
    data['description'] = this.description;
    data['description_er'] = this.descriptionEr;
    data['price'] = this.price;
    data['business_id'] = this.businessId;
    data['state'] = this.state;
    data['product_profile_img'] = this.productProfileImg;
    return data;
  }
}

class PackageDetail {
  int? packageId;
  String? name;
  String? nameEr;
  String? description;
  String? descriptionEr;
  double? price;
  int? businessId;
  int? state;
  String? packageProfileImg;

  PackageDetail(
      {this.packageId,
      this.name,
      this.nameEr,
      this.description,
      this.descriptionEr,
      this.price,
      this.businessId,
      this.state,
      this.packageProfileImg});

  PackageDetail.fromJson(Map<String, dynamic> json) {
    packageId = json['package_id'];
    name = json['name'];
    nameEr = json['name_er'];
    description = json['description'];
    descriptionEr = json['description_er'];
    price = json['price'];
    businessId = json['business_id'];
    state = json['state'];
    packageProfileImg = json['package_profile_img'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['package_id'] = this.packageId;
    data['name'] = this.name;
    data['name_er'] = this.nameEr;
    data['description'] = this.description;
    data['description_er'] = this.descriptionEr;
    data['price'] = this.price;
    data['business_id'] = this.businessId;
    data['state'] = this.state;
    data['package_profile_img'] = this.packageProfileImg;
    return data;
  }
}
