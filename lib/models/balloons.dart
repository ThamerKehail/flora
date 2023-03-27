class Balloons {
  int? id;
  String? fname;
  String? lname;
  String? email;
  double? city;
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
  String? createdAt;
  String? updatedAt;

  Balloons(
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
      this.createdAt,
      this.updatedAt});

  Balloons.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    fname = json['Fname'];
    lname = json['Lname'] ?? "";
    email = json['email'];
    city = json['city'].toDouble();
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
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }

  static List<Balloons> asListFromJson(List<dynamic> json) {
    var result = <Balloons>[];
    for (var item in json) {
      result.add(Balloons.fromJson(item));
    }

    return result;
  }
}
