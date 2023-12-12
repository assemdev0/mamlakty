import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../app/constant/api_constant.dart';
import '../../../app/services/dio_helper/dio_helper.dart';
import '../../../app/services/shared_prefrences/cache_helper.dart';
import '../../../model/product_model.dart';
import 'states.dart';

class ProductDetailsBloc extends Cubit<ProductDetailsStates> {
  ProductDetailsBloc() : super(ProductDetailsInitState());
  static ProductDetailsBloc get(context) => BlocProvider.of(context);

  int productCounter = 1;
  void incrementProductCounter() {
    productCounter++;
    emit(IncrementProductCounterState());
  }

  void decrementProductCounter() {
    if (productCounter <= 1) {
      productCounter = 1;
    } else {
      productCounter--;
    }

    emit(DecrementProductCounterState());
  }

  List<String> banners = [];

  ProductDetailsModel productDetailsModel = ProductDetailsModel();
  void getProductDetails({required int id}) {
    emit(ProductDetailsLoadingState());
    DioHelper.getData(path: ApiConstant.productDetailsPath(id: id))
        .then((value) {
      productDetailsModel = ProductDetailsModel.fromJson(value.data);
      for (var element in productDetailsModel.data.images) {
        banners.add(element.image);
      }

      emit(ProductDetailsSuccessState());
    }).catchError((error) {
      emit(ProductDetailsErrorState());
    });
  }

  ProductModel productModel = ProductModel();
  void getSimilarProducts({required int id}) {
    emit(SimilarProductLoadingState());
    DioHelper.getData(
        path: ApiConstant.productInCategoryPath(id: id),
        queryParameters: {
          "page": 1,
        }).then((value) {
      productModel = ProductModel.fromJson(value.data);
      emit(SimilarProductSuccessState());
    }).catchError((error) {
      emit(SimilarProductErrorState());
    });
  }

  void addToCart({
    required int productId,
  }) {
    emit(AddToCartLoadingState());
    DioHelper.postData(
            path: ApiConstant.addToCartPath,
            data: {
              "product_id": productId,
              "quantity": productCounter,
            },
            token: CacheHelper.getData(key: SharedKey.token))
        .then((value) {
      emit(AddToCartSuccessState());
    }).catchError((error) {
      emit(AddToCartErrorState());
    });
  }

  void addToFavorites({required int productId}) {
    emit(AddToFavoritesLoadingState());
    DioHelper.postData(
        path: ApiConstant.addToFavoritesPath,
        token: CacheHelper.getData(key: SharedKey.token),
        data: {
          "product_id": productId,
        }).then((value) {
      emit(AddToFavoritesSuccessState());
    }).catchError((error) {
      emit(AddToFavoritesErrorState());
    });
  }

  void removeFromFavorites({
    required int productId,
  }) {
    emit(RemoveFromFavoritesLoadingState());
    DioHelper.delData(
            path: ApiConstant.removeFromFavoritesPath(
              id: productId,
            ),
            token: CacheHelper.getData(key: SharedKey.token))
        .then((value) {
      emit(RemoveFromFavoritesSuccessState());
    }).catchError((error) {
    
      emit(RemoveFromFavoritesErrorState());
    });
  }
}
