import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mamlakty/model/area_model.dart';

import '../../../app/constant/api_constant.dart';
import '../../../app/services/dio_helper/dio_helper.dart';
import '../../../model/user_model.dart';
import 'states.dart';

class AuthBloc extends Cubit<AuthStates> {
  AuthBloc() : super(AuthInitState());
  static AuthBloc get(context) => BlocProvider.of(context);
  bool isShownConfirmPassword = true;
  bool isShownPassword = true;
  Icon suffixPassword = const Icon(Icons.visibility_off_outlined);
  Icon suffixConfirmPassword = const Icon(Icons.visibility_off_outlined);

  void changeVisibilityPassword() {
    isShownPassword = !isShownPassword;

    suffixPassword = isShownPassword
        ? const Icon(Icons.visibility_off_outlined)
        : const Icon(Icons.visibility_outlined);

    emit(ChangeVisibilityPasswordState());
  }

  void changeVisibilityConfirmPassword() {
    isShownConfirmPassword = !isShownConfirmPassword;

    suffixConfirmPassword = isShownConfirmPassword
        ? const Icon(Icons.visibility_off_outlined)
        : const Icon(Icons.visibility_outlined);
    emit(ChangeVisibilityPasswordState());
  }

  UserModel userModel = UserModel();

  void loginUser({
    required String email,
    required String password,
  }) {
    emit(LoginLoadingState());
    DioHelper.postData(path: ApiConstant.loginUserPath, data: {
      "email": email,
      "password": password,
    }).then((value) {
      userModel = UserModel.fromJson(value.data);
      emit(LoginSuccessState());
    }).catchError((error) {
      emit(LoginErrorState());
    });
  }

  List<String> areaList = [];

  String? selectedValue;
  void changeDropDownItem({required String value}) {
    selectedValue = value;
    areaCoast();
    areaId();
    emit(ChangeDropDownValueState());
  }

  String areaCoast() {
    String? coast;
    for (var element in areaModel.data) {
      if (element.area == selectedValue) {
        coast = element.cost;
      }
    }
    return coast!;
  }

  int areaId() {
    int? id;
    for (var element in areaModel.data) {
      if (element.area == selectedValue) {
        id = element.id;
      }
    }
    return id!;
  }

  AreaModel areaModel = AreaModel();
  void getArea() {
    emit(GetAreaLoadingState());
    DioHelper.getData(
      path: ApiConstant.getAreaPath,
    ).then(
      (value) {
        areaModel = AreaModel.fromJson(value.data);
        for (var element in areaModel.data) {
          areaList.add(element.area);
        }
        emit(GetAreaSuccessState());
      },
    ).catchError(
      (error) {
        emit(GetAreaErrorState());
      },
    );
  }
}
