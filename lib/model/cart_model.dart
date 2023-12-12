
import 'product_model.dart';

class CartModel {
  List<CartDataModel> data = [];
  CartModel();
  CartModel.fromJson(Map<String, dynamic> json) {
    json["data"].forEach((element) {
      data.add(CartDataModel.fromJson(element));
    });
  }
}

class CartDataModel {
  late int id;
  late int cartId;
  late int quantity;
  DataModel productDataModel = DataModel();
  CartDataModel();
  CartDataModel.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    cartId = json["cart_id"];
    quantity = json["quantity"];
    productDataModel = DataModel.fromJson(json["product"]);
  }
}
