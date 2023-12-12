
import '../app/constant/api_constant.dart';

class BannerModel {
  List<BannerDataModel> data = [];
  BannerModel();
  BannerModel.fromJson(Map<String, dynamic> json) {
    json["data"].forEach((element) {
      data.add(BannerDataModel.fromJson(element));
    });
  }
}

class BannerDataModel {
  late int id;
  late String image;
  BannerDataModel();
  BannerDataModel.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    image = "${ApiConstant.baseUrl}storage/${json["image"]}";
  }
}
