class AllUserModel {
  int? id;
  String? fname;
  String? lname;
  String? email;
  String? mobile;
  String? profileImage;
  int? rate;

  AllUserModel(
      {this.id,
      this.fname,
      this.lname,
      this.email,
      this.mobile,
      this.profileImage,
      this.rate});

  AllUserModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    fname = json['Fname'];
    lname = json['Lname'];
    email = json['email'];
    mobile = json['mobile'];
    profileImage = json['profile_image'];
    rate = json['rate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = id;
    data['Fname'] = fname;
    data['Lname'] = lname;
    data['email'] = email;
    data['mobile'] = mobile;
    data['profile_image'] = profileImage;
    data['rate'] = rate;
    return data;
  }

  static List<AllUserModel> asListFromJson(List<dynamic> json) {
    var result = <AllUserModel>[];
    for (var item in json) {
      result.add(AllUserModel.fromJson(item));
    }

    return result;
  }
}
