
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../app/constant/api_constant.dart';
import '../../../app/services/dio_helper/dio_helper.dart';
import '../../../app/services/shared_prefrences/cache_helper.dart';
import '../../../model/user_model.dart';
import 'states.dart';

class ProfileBLoc extends Cubit<ProfileStates> {
  ProfileBLoc() : super(ProfileInitState());
  static ProfileBLoc get(context) => BlocProvider.of(context);
  UserDataModel userDataModel = UserDataModel();
  void getProfile() {
    emit(ProfileLoadingState());
    DioHelper.getData(
            path: ApiConstant.getProfile,
            token: CacheHelper.getData(key: SharedKey.token))
        .then((value) {
      userDataModel = UserDataModel.fromJson(value.data);
      emit(ProfileSuccessState());
    }).catchError((error) {
      emit(ProfileErrorState());
    });
  }

  void editUser({
    String? email,
    String? password,
    String? name,
    String? phone,
  }) {
    emit(EditProfileLoadingState());
    DioHelper.updateData(
      path: ApiConstant.editUserPath,
      token: CacheHelper.getData(key: SharedKey.token),
      data: {
        "user_id": CacheHelper.getData(key: SharedKey.id),
        "email": email,
        "password": password,
        "password_confirmation": password,
        "name": name,
        "phone": phone,
      },
    ).then((value) {
      getProfile();
      emit(EditProfileSuccessState());
    }).catchError((error) {
      emit(EditProfileErrorState());
    });
  }
}
