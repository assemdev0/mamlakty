
import 'product_model.dart';

class FavoritesModel {
  List<FavoritesDataModel> data = [];
  FavoritesModel();
  FavoritesModel.fromJson(Map<String, dynamic> json) {
    json["data"].forEach((element) {
      data.add(FavoritesDataModel.fromJson(element));
    });
  }
}

class FavoritesDataModel {
  DataModel productDataModel = DataModel();
  FavoritesDataModel();
  FavoritesDataModel.fromJson(Map<String, dynamic> json) {
    productDataModel = DataModel.fromJson(json["product"]);
  }
}
