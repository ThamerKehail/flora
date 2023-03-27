class BalloonsBannerModel {
  int? id;
  String? bannerImg;

  BalloonsBannerModel({this.id, this.bannerImg});

  BalloonsBannerModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    bannerImg = json['banner_img'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['banner_img'] = bannerImg;
    return data;
  }

  static List<BalloonsBannerModel> asListFromJson(List<dynamic> json) {
    var result = <BalloonsBannerModel>[];
    for (var item in json) {
      result.add(BalloonsBannerModel.fromJson(item));
    }
    return result;
  }
}
