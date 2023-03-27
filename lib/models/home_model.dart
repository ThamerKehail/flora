class HomeModel {
  List<HomeImage>? image;
  List<Banner>? banner;
  List<Catrgory>? catrgory;
  List<User>? user;

  HomeModel({this.image, this.banner, this.catrgory, this.user});

  HomeModel.fromJson(Map<String, dynamic> json) {
    if (json['image'] != null) {
      image = <HomeImage>[];
      json['image'].forEach((v) {
        image!.add(new HomeImage.fromJson(v));
      });
    }
    if (json['banner'] != null) {
      banner = <Banner>[];
      json['banner'].forEach((v) {
        banner!.add(new Banner.fromJson(v));
      });
    }
    if (json['catrgory'] != null) {
      catrgory = <Catrgory>[];
      json['catrgory'].forEach((v) {
        catrgory!.add(new Catrgory.fromJson(v));
      });
    }
    if (json['user'] != null) {
      user = <User>[];
      json['user'].forEach((v) {
        user!.add(new User.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.image != null) {
      data['image'] = this.image!.map((v) => v.toJson()).toList();
    }
    if (this.banner != null) {
      data['banner'] = this.banner!.map((v) => v.toJson()).toList();
    }
    if (this.catrgory != null) {
      data['catrgory'] = this.catrgory!.map((v) => v.toJson()).toList();
    }
    if (this.user != null) {
      data['user'] = this.user!.map((v) => v.toJson()).toList();
    }
    return data;
  }

  static List<HomeModel> asListFromJson(List<dynamic> json) {
    var result = <HomeModel>[];
    for (var item in json) {
      result.add(HomeModel.fromJson(item));
    }
    return result;
  }
}

class HomeImage {
  int? id;
  String? bannerImg;

  HomeImage({this.id, this.bannerImg});

  HomeImage.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    bannerImg = json['banner_img'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['banner_img'] = this.bannerImg;
    return data;
  }
}

class Banner {
  int? id;
  String? bannerImg;

  Banner({this.id, this.bannerImg});

  Banner.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    bannerImg = json['banner_img'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['banner_img'] = this.bannerImg;
    return data;
  }
}

class Catrgory {
  int? categoryID;
  String? categoryName;
  String? categoryBanner;

  Catrgory({this.categoryID, this.categoryName, this.categoryBanner});

  Catrgory.fromJson(Map<String, dynamic> json) {
    categoryID = json['CategoryID'];
    categoryName = json['Category_Name'];
    categoryBanner = json['Category_banner'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['CategoryID'] = this.categoryID;
    data['Category_Name'] = this.categoryName;
    data['Category_banner'] = this.categoryBanner;
    return data;
  }
}

class User {
  int? id;
  String? fname;
  String? lname;
  String? email;
  String? mobile;
  String? profileImage;
  int? rate;

  User(
      {this.id,
      this.fname,
      this.lname,
      this.email,
      this.mobile,
      this.profileImage,
      this.rate});

  User.fromJson(Map<String, dynamic> json) {
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
    data['id'] = this.id;
    data['Fname'] = this.fname;
    data['Lname'] = this.lname;
    data['email'] = this.email;
    data['mobile'] = this.mobile;
    data['profile_image'] = this.profileImage;
    data['rate'] = this.rate;
    return data;
  }
}
