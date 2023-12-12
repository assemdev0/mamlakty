import '../app/constant/api_constant.dart';
import 'category_model.dart';

class ProductModel {
  ProductDataModel data = ProductDataModel();
  ProductModel();
  ProductModel.fromJson(Map<String, dynamic> json) {
    data = ProductDataModel.fromJson(json["data"]);
  }
}

class ProductDataModel {
  List<DataModel> data = [];
  ProductDataModel();
  ProductDataModel.fromJson(Map<String, dynamic> json) {
    json["data"].forEach((element) {
      data.add(DataModel.fromJson(element));
    });
  }
}

class DataModel {
  late int id;
  late String name;
  late String description;
  late String price;
  late int stock;
  CategoryDataModel category = CategoryDataModel();
  List<ImageProductModel> images = [];
  DataModel();
  DataModel.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    name = json["name"];
    description = json["description"];
    price = json["price"];
    stock = json["stock"];
    json["images"].forEach(
      (element) {
        images.add(ImageProductModel.fromJson(element));
      },
    );
    category = CategoryDataModel.fromJson(json["category"]);
  }
}

class ImageProductModel {
  late String image;
  ImageProductModel();
  ImageProductModel.fromJson(Map<String, dynamic> json) {
    image = "${ApiConstant.baseUrl}storage/${json["image"]}";
  }
}

class ProductDetailsModel {
  DataModel data = DataModel();
  ProductDetailsModel();
  ProductDetailsModel.fromJson(Map<String, dynamic> json) {
    data = DataModel.fromJson(json["data"]);
  }
}
