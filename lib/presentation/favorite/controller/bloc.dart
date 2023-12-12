import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../app/constant/api_constant.dart';
import '../../../app/services/dio_helper/dio_helper.dart';
import '../../../app/services/shared_prefrences/cache_helper.dart';
import '../../../model/favorites_model.dart';
import 'states.dart';

class FavoritesBloc extends Cubit<FavoritesStates> {
  FavoritesBloc() : super(FavoriteInitState());
  static FavoritesBloc get(context) => BlocProvider.of(context);

  FavoritesModel favoritesModel = FavoritesModel();
  void getFavorites() {
    emit(FavoriteLoadingState());
    DioHelper.getData(
            path: ApiConstant.getFavoritesPath,
            token: CacheHelper.getData(key: SharedKey.token))
        .then((value) {
      favoritesModel = FavoritesModel.fromJson(value.data);
      emit(FavoriteSuccessState());
    }).catchError((error) {
      emit(FavoriteErrorState());
    });
  }
}
