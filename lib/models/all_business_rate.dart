class AllBusinessRate {
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
  List<OrdersCheack>? ordersCheack;

  AllBusinessRate(
      {this.orderId,
      this.city,
      this.address,
      this.strretName,
      this.building,
      this.floor,
      this.mobile,
      this.userId,
      this.businessId,
      this.status,
      this.ordersCheack});

  AllBusinessRate.fromJson(Map<String, dynamic> json) {
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
    if (json['orders_cheack'] != null) {
      ordersCheack = <OrdersCheack>[];
      json['orders_cheack'].forEach((v) {
        ordersCheack!.add(new OrdersCheack.fromJson(v));
      });
    }
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
    if (this.ordersCheack != null) {
      data['orders_cheack'] =
          this.ordersCheack!.map((v) => v.toJson()).toList();
    }
    return data;
  }

  static List<AllBusinessRate> asListFromJson(List<dynamic> json) {
    var result = <AllBusinessRate>[];
    for (var item in json) {
      result.add(AllBusinessRate.fromJson(item));
    }
    return result;
  }
}

class OrdersCheack {
  int? id;
  String? fname;
  String? lname;
  String? email;
  int? city;
  String? mobile;
  int? isAdmin;
  String? businessDescription;
  String? address;
  int? category;
  int? state;
  String? long;
  String? lat;
  int? from;
  int? to;
  String? cover;
  String? emailVerifiedAt;
  String? profileImage;
  int? rate;
  String? createdAt;
  String? updatedAt;

  OrdersCheack(
      {this.id,
      this.fname,
      this.lname,
      this.email,
      this.city,
      this.mobile,
      this.isAdmin,
      this.businessDescription,
      this.address,
      this.category,
      this.state,
      this.long,
      this.lat,
      this.from,
      this.to,
      this.cover,
      this.emailVerifiedAt,
      this.profileImage,
      this.rate,
      this.createdAt,
      this.updatedAt});

  OrdersCheack.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    fname = json['Fname'];
    lname = json['Lname'];
    email = json['email'];
    city = json['city'];
    mobile = json['mobile'];
    isAdmin = json['is_admin'];
    businessDescription = json['business_Description'];
    address = json['address'];
    category = json['category'];
    state = json['state'];
    long = json['long'];
    lat = json['lat'];
    from = json['from'];
    to = json['to'];
    cover = json['cover'];
    emailVerifiedAt = json['email_verified_at'];
    profileImage = json['profile_image'];
    rate = json['rate'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['Fname'] = this.fname;
    data['Lname'] = this.lname;
    data['email'] = this.email;
    data['city'] = this.city;
    data['mobile'] = this.mobile;
    data['is_admin'] = this.isAdmin;
    data['business_Description'] = this.businessDescription;
    data['address'] = this.address;
    data['category'] = this.category;
    data['state'] = this.state;
    data['long'] = this.long;
    data['lat'] = this.lat;
    data['from'] = this.from;
    data['to'] = this.to;
    data['cover'] = this.cover;
    data['email_verified_at'] = this.emailVerifiedAt;
    data['profile_image'] = this.profileImage;
    data['rate'] = this.rate;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
