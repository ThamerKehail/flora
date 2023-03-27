class Client {
  int? id;
  String? fname;
  String? lname;
  String? email;
  String? mobile;
  String? profileImage;

  Client(
      {this.id,
      this.fname,
      this.lname,
      this.email,
      this.mobile,
      this.profileImage});

  Client.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    fname = json['Fname'];
    lname = json['Lname'];
    email = json['email'];
    mobile = json['mobile'];
    profileImage = json['profile_image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['Fname'] = this.fname;
    data['Lname'] = this.lname;
    data['email'] = this.email;
    data['mobile'] = this.mobile;
    data['profile_image'] = this.profileImage;
    return data;
  }

  static List<Client> asListFromJson(List<dynamic> json) {
    var result = <Client>[];
    for (var item in json) {
      result.add(Client.fromJson(item));
    }
    return result;
  }
}
