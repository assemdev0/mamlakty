class UserModel {
  late String token;
  UserDataModel data = UserDataModel();
  UserModel();
  UserModel.fromJson(Map<String, dynamic> json) {
    token = json["token"];
    data = UserDataModel.fromJson(json["data"]);
  }
}

class UserDataModel {
  late int id;
  late String name;
  late String email;
  late String address;
  late String phone;
  UserDataModel();
  UserDataModel.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    name = json["name"];
    email = json["email"];
    address = json["address"];
    phone = json["phone"];
  }
}
