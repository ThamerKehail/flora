class BusinessRated {
  int? orderId;
  int? userId;

  BusinessRated({this.orderId, this.userId});

  BusinessRated.fromJson(Map<String, dynamic> json) {
    orderId = json['order_id'];
    userId = json['user_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['order_id'] = this.orderId;
    data['user_id'] = this.userId;
    return data;
  }

  static List<BusinessRated> asListFromJson(List<dynamic> json) {
    var result = <BusinessRated>[];
    for (var item in json) {
      result.add(BusinessRated.fromJson(item));
    }
    return result;
  }
}
