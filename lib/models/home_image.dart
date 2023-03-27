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
  static List<HomeImage> asListFromJson(List<dynamic> json) {
    var result = <HomeImage>[];
    for (var item in json) {
      result.add(HomeImage.fromJson(item));
    }
    return result;
  }

}