// ignore_for_file: deprecated_member_use

import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../app/constant/api_constant.dart';
import '../../../app/services/dio_helper/dio_helper.dart';
import '../../../app/services/shared_prefrences/cache_helper.dart';
import '../../../model/orders_model.dart';
import 'states.dart';

class OrderBloc extends Cubit<OrdersStates> {
  OrderBloc() : super(OrdersInitState());
  static OrderBloc get(context) => BlocProvider.of(context);
  OrdersModel ordersModel = OrdersModel();
  void getOrders() {
    emit(OrdersLoadingState());
    DioHelper.getData(
            path: ApiConstant.ordersPath,
            token: CacheHelper.getData(key: SharedKey.token))
        .then((value) {
      ordersModel = OrdersModel.fromJson(value.data);
      emit(OrdersSuccessState());
    }).catchError((error) {
      emit(OrdersErrorState());
    });
  }
}
