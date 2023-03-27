class BannerModel {
  int? id;
  String? bannerImg;

  BannerModel({this.id, this.bannerImg});

  BannerModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    bannerImg = json['banner_img'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['banner_img'] = bannerImg;
    return data;
  }

  static List<BannerModel> asListFromJson(List<dynamic> json) {
    var result = <BannerModel>[];
    for (var item in json) {
      result.add(BannerModel.fromJson(item));
    }
    return result;
  }
}
