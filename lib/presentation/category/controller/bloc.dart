import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../app/constant/api_constant.dart';
import '../../../app/services/dio_helper/dio_helper.dart';
import '../../../model/category_model.dart';
import 'states.dart';

class CategoryBloc extends Cubit<CategoryStates> {
  CategoryBloc() : super(CategoryInitState());
  static CategoryBloc get(context) => BlocProvider.of(context);

  CategoryModel categoryModel = CategoryModel();
  void getCategories() {
    emit(CategoryLoadingState());
    DioHelper.getData(
      path: ApiConstant.categoriesPath,
    ).then((value) {
      categoryModel = CategoryModel.fromJson(value.data);
      emit(CategorySuccessState());
    }).catchError((error) {
      emit(CategoryErrorState());
    });
  }
}
