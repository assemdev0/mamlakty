import '../app/constant/api_constant.dart';

class CategoryModel {
  List<CategoryDataModel> data = [];
  CategoryModel();
  CategoryModel.fromJson(Map<String, dynamic> json) {
    json["data"].forEach(
      (element) {
        data.add(CategoryDataModel.fromJson(element));
      },
    );
  }
}

class CategoryDataModel {
  late int id;
  late String name;
  late String image;
  CategoryDataModel();
  CategoryDataModel.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    name = json["name"];
    image = "${ApiConstant.baseUrl}storage/categories/${json["image"]}";
  }
}
