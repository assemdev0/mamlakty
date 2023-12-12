import 'product_model.dart';

class OrdersModel {
  List<OrdersDataModel> data = [];
  OrdersModel();
  OrdersModel.fromJson(Map<String, dynamic> json) {
    json["data"].forEach((element) {
      data.add(OrdersDataModel.fromJson(element));
    });
  }
}

class OrdersDataModel {
  late int id;
  late String status;
  late String totalPrice;
  late String createdAt;
  late String name;
  late String address;
  late String phone;
  late String deliveryCoast;

  List<OrdersItemsModel> items = [];
  OrdersDataModel();
  OrdersDataModel.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    name = json["name"];
    status = json["status"];
    address = json["address"];
    phone = json["phone"];
    totalPrice = json["total_price"];
    createdAt = json["created_at"];
    deliveryCoast = json["delivery_fees"];
    json["items"].forEach((element) {
      items.add(OrdersItemsModel.fromJson(element));
    });
  }
}

class OrdersItemsModel {
  late int id;
  late int orderId;
  late int quantity;
  late String price;
  DataModel product = DataModel();
  OrdersItemsModel();
  OrdersItemsModel.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    orderId = json["order_id"];
    quantity = json["quantity"];
    price = json["price"];
    product = DataModel.fromJson(json["product"]);
  }
}
