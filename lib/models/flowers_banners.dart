class FlowersBannerModel {
  int? id;
  String? bannerImg;

  FlowersBannerModel({this.id, this.bannerImg});

  FlowersBannerModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    bannerImg = json['banner_img'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['banner_img'] = bannerImg;
    return data;
  }

  static List<FlowersBannerModel> asListFromJson(List<dynamic> json) {
    var result = <FlowersBannerModel>[];
    for (var item in json) {
      result.add(FlowersBannerModel.fromJson(item));
    }
    return result;
  }
}
