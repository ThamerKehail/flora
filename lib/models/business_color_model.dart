class BusinessColors {
  String? colorID;
  int? storeId;

  BusinessColors({this.colorID, this.storeId});

  BusinessColors.fromJson(Map<String, dynamic> json) {
    colorID = json['ColorID'];
    storeId = json['store_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ColorID'] = this.colorID;
    data['store_id'] = this.storeId;
    return data;
  }

  static List<BusinessColors> asListFromJson(List<dynamic> json) {
    var result = <BusinessColors>[];
    for (var item in json) {
      result.add(BusinessColors.fromJson(item));
    }

    return result;
  }
}
