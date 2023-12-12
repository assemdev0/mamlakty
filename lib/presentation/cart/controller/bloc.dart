// ignore_for_file: deprecated_member_use

import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../app/constant/api_constant.dart';
import '../../../app/services/dio_helper/dio_helper.dart';
import '../../../app/services/shared_prefrences/cache_helper.dart';
import '../../../model/cart_model.dart';
import 'states.dart';

class CartBloc extends Cubit<CartStates> {
  CartBloc() : super(CartInitState());
  static CartBloc get(context) => BlocProvider.of(context);
  void incrementProductCounter() {
    emit(IncrementProductCounterState());
  }

  void decrementProductCounter() {
    emit(DecrementProductCounterState());
  }

  CartModel cartModel = CartModel();
  List<Map<String, int>> productsListInCart = [];
  void getCart() {
    emit(CartLoadingState());
    DioHelper.getData(
            path: ApiConstant.getCart,
            token: CacheHelper.getData(key: SharedKey.token))
        .then((value) {
      cartModel = CartModel.fromJson(value.data);
      productsListInCart = [];
      for (var element in cartModel.data) {
        Map<String, int> product = {
          "id": element.productDataModel.id,
          "quantity": element.quantity
        };
        productsListInCart.add(product);
      }
      emit(CartSuccessState());
    }).catchError((error) {
      emit(CartErrorState());
    });
  }

  void checkoutOrder({
    required String name,
    required String address,
    required String phone,
    required String note,
    required int deliveryAreaId,
  }) {
    emit(CheckoutOrderLoadingState());
    DioHelper.postData(
      path: ApiConstant.checkoutPath,
      token: CacheHelper.getData(key: SharedKey.token),
      data: {
        "delivery_area_id": deliveryAreaId,
        "products": productsListInCart,
        "name": name,
        "address": address,
        "phone": phone,
        "notes": note
      },
    ).then(
      (value) {
        emit(CheckoutOrderSuccessState());
      },
    ).catchError((error) {
      emit(CheckoutOrderErrorState());
    });
  }

  double totalPrice({double? deliveryCoast}) {
    double total = 0.0;
    deliveryCoast ??= 0;
    for (var element in cartModel.data) {
      double productPrice = 0.0;
      productPrice =
          element.quantity * double.parse(element.productDataModel.price);
      total = total + productPrice;
    }
    return total + deliveryCoast;
  }

  void editCart({required int productId, int? quantity}) {
    emit(EditCartLoadingState());
    DioHelper.updateData(
      path: ApiConstant.editCart,
      token: CacheHelper.getData(key: SharedKey.token),
      data: {
        "product_id": productId,
        "quantity": quantity,
      },
    ).then((value) {
      getCart();
      emit(EditCartSuccessState());
    }).catchError((error) {
      emit(EditCartErrorState());
    });
  }
}
