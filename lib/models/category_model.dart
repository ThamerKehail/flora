class CategoryModel {
  late final int categoryID;
  late final String categoryName;
  late final String categoryBanner;

  CategoryModel(
      {required this.categoryID,
      required this.categoryName,
      required this.categoryBanner});

  CategoryModel.fromJson(
    Map<String, dynamic> json,
  ) {
    categoryID = json['CategoryID'];
    categoryName = json['Category_Name'];
    categoryBanner = json['Category_banner'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['CategoryID'] = categoryID;
    data['Category_Name'] = categoryName;
    data['Category_banner'] = categoryBanner;
    return data;
  }

  static List<CategoryModel> asListFromJson(List<dynamic> json) {
    var result = <CategoryModel>[];
    for (var item in json) {
      result.add(CategoryModel.fromJson(item));
    }
    return result;
  }
}
