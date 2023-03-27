class FlowersBalloonsBannerModel {
  int? id;
  String? bannerImg;

  FlowersBalloonsBannerModel({this.id, this.bannerImg});

  FlowersBalloonsBannerModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    bannerImg = json['banner_img'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['banner_img'] = bannerImg;
    return data;
  }

  static List<FlowersBalloonsBannerModel> asListFromJson(List<dynamic> json) {
    var result = <FlowersBalloonsBannerModel>[];
    for (var item in json) {
      result.add(FlowersBalloonsBannerModel.fromJson(item));
    }
    return result;
  }
}
