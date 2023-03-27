class AllPlacesBannerModel {
  int? id;
  String? bannerImg;

  AllPlacesBannerModel({this.id, this.bannerImg});

  AllPlacesBannerModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    bannerImg = json['banner_img'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['banner_img'] = bannerImg;
    return data;
  }

  static List<AllPlacesBannerModel> asListFromJson(List<dynamic> json) {
    var result = <AllPlacesBannerModel>[];
    for (var item in json) {
      result.add(AllPlacesBannerModel.fromJson(item));
    }
    return result;
  }
}
