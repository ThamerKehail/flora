import 'dart:convert';

// List<Places> placesModelFromJson(String str) =>
//     List<Places>.from(json.decode(str).map((x) => Places.fromJson(x)));
// String placesModelToJson(List<Places> data) =>
//     json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Places {
  int? id;
  String? fname;
  String? lName;
  String? email;
  String? mobile;
  String? businessDescription;
  String? address;
  double? city;
  int? category;
  int? state;
  String? long;
  String? lat;
  int? from;
  int? to;
  String? cover;
  String? profileImage;

  Places(
      {this.id,
      this.fname,
      this.lName,
      this.email,
      this.mobile,
      this.businessDescription,
      this.address,
      this.category,
      this.state,
      this.long,
      this.lat,
      this.city,
      this.from,
      this.to,
      this.cover,
      this.profileImage});

  Places.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    fname = json['Fname'];
    lName = json['Lname'] ?? "";
    email = json['email'];
    mobile = json['mobile'];
    city = json['city'].toDouble();
    businessDescription = json['business_Description'];
    address = json['address'];
    category = json['category'];
    state = json['state'];
    long = json['long'];
    lat = json['lat'];
    from = json['from'];
    to = json['to'];
    cover = json['cover'];
    profileImage = json['profile_image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['Fname'] = fname;
    data['Lname'] = lName;
    data['email'] = email;
    data['city'] = city;
    data['mobile'] = mobile;
    data['business_Description'] = businessDescription;
    data['address'] = address;
    data['category'] = category;
    data['state'] = state;
    data['long'] = long;
    data['lat'] = lat;
    data['from'] = from;
    data['to'] = to;
    data['cover'] = cover;
    data['profile_image'] = profileImage;
    return data;
  }

  static List<Places> asListFromJson(List<dynamic> json) {
    var result = <Places>[];
    for (var item in json) {
      result.add(Places.fromJson(item));
    }

    return result;
  }
}
