class AvgBusinessRate {
  int? id;
  String? fname;
  Null? lname;
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
  Null? emailVerifiedAt;
  String? profileImage;
  int? rate;
  String? createdAt;
  String? updatedAt;

  AvgBusinessRate(
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

  AvgBusinessRate.fromJson(Map<String, dynamic> json) {
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

  static List<AvgBusinessRate> asListFromJson(List<dynamic> json) {
    var result = <AvgBusinessRate>[];
    for (var item in json) {
      result.add(AvgBusinessRate.fromJson(item));
    }

    return result;
  }
}
