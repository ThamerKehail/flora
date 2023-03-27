class Orders {
  int? id;
  int? orderId;
  int? businessId;
  int? userID;
  int? paymentMethod;
  int? productId;
  int? qty;
  dynamic singlePrice;
  dynamic totalPrice;
  int? color;
  String? image;
  String? name;
  String? message;
  int? type;
  String? createdAt;
  String? updatedAt;
  List<OrdersAddres>? ordersAddres;

  Orders(
      {this.id,
      this.orderId,
      this.businessId,
      this.userID,
      this.paymentMethod,
      this.productId,
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
      this.ordersAddres});

  Orders.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    orderId = json['order_id'];
    businessId = json['business_id'];
    userID = json['userID'];
    paymentMethod = json['payment_method'];
    productId = json['product_id'];
    qty = json['Qty'];
    singlePrice = json['single_price'].toDouble();
    totalPrice = json['total_price'].toDouble();
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
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['order_id'] = this.orderId;
    data['business_id'] = this.businessId;
    data['userID'] = this.userID;
    data['payment_method'] = this.paymentMethod;
    data['product_id'] = this.productId;
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
