class Package {
  late final int packageId;
  late final String name;
  late final String nameEr;
  late final String description;
  late final String descriptionEr;
  late final String businessEmail;
  dynamic price;
  late final int businessId;
  late final int state;
  late final String packageProfileImg;
  List<AllPackageBus>? allPackageBus;

  Package({
    required this.packageId,
    required this.name,
    required this.nameEr,
    required this.description,
    required this.descriptionEr,
    required this.price,
    required this.businessId,
    required this.state,
    required this.packageProfileImg,
    this.allPackageBus,
    required this.businessEmail,
  });

  Package.fromJson(Map<String, dynamic> json) {
    packageId = json['package_id'];
    name = json['name'];
    nameEr = json['name_er'];
    description = json['description'];
    descriptionEr = json['description_er'];
    price = double.parse(json['price'].toString());
    businessId = json['business_id'];
    state = json['state'];
    packageProfileImg = json['package_profile_img'];
    if (json['all__package_bus'] != null) {
      allPackageBus = <AllPackageBus>[];
      json['all__package_bus'].forEach((v) {
        allPackageBus!.add(new AllPackageBus.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['package_id'] = packageId;
    data['name'] = name;
    data['name_er'] = nameEr;
    data['description'] = description;
    data['description_er'] = descriptionEr;
    data['price'] = price;
    data['business_id'] = businessId;
    data['state'] = state;
    data['package_profile_img'] = packageProfileImg;
    if (allPackageBus != null) {
      data['all__package_bus'] = allPackageBus!.map((v) => v.toJson()).toList();
    }
    return data;
  }

  static List<Package> asListFromJson(List<dynamic> json) {
    var result = <Package>[];
    for (var item in json) {
      result.add(Package.fromJson(item));
    }
    return result;
  }
}

class AllPackageBus {
  int? color;

  AllPackageBus({this.color});

  AllPackageBus.fromJson(Map<String, dynamic> json) {
    color = json['color'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['color'] = color;
    return data;
  }
}
