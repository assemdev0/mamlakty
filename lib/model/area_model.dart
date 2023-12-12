class AreaModel {
  List<AreaDataModel> data = [];
  AreaModel();
  AreaModel.fromJson(Map<String, dynamic> json) {
    json["data"].forEach((element) {
      data.add(AreaDataModel.fromJson(element));
    });
  }
}

class AreaDataModel {
  late int id;
  late String area;
  late String cost;
  AreaDataModel();
  AreaDataModel.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    area = json["area"];
    cost = json["cost"];
  }
}
