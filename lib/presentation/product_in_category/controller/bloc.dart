// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../app/constant/api_constant.dart';
import '../../../app/services/dio_helper/dio_helper.dart';
import '../../../model/product_model.dart';
import 'states.dart';

class ProductInCategoryBloc extends Cubit<ProductInCategoryStates> {
  ProductInCategoryBloc() : super(ProductInCategoryInitState());
  static ProductInCategoryBloc get(context) => BlocProvider.of(context);
  int pageNumber = 1;
  bool isFirstLoading = false;
  bool hasPages = true;
  bool isMoreLoading = false;
  double sliderValue = 0.0;
  ProductModel productModel = ProductModel();
  List<DataModel> productList = [];
  List<DataModel> productMoreList = [];
  late int categoryId;

  ProductDataModel serchProduct = ProductDataModel();
  void seachInCategory({
    required int categoryId,
   required String name,
    double? maxPrice,
  }) {
    emit(SearchInCategoryLoadingState());
    DioHelper.postData(
      path: ApiConstant.searchInCategoryPath,
      data: {
        "category_id": categoryId,
        "name": name,
        "min_price": 0,
        "max_price": maxPrice,
      },
    ).then((value) {
      serchProduct = ProductDataModel.fromJson(value.data);
      emit(SearchInCategorySuccessState());
    }).catchError((error) {
 
      emit(SearchInCategoryErrorState());
    });
  }

 void seachInCategoryWithName({
    required int categoryId,
   required String name,
  }) {
    emit(SearchInCategoryLoadingState());
    DioHelper.postData(
      path: ApiConstant.searchInCategoryPath,
      data: {
        "category_id": categoryId,
        "name": name,
      },
    ).then((value) {
      serchProduct = ProductDataModel.fromJson(value.data);
      emit(SearchInCategorySuccessState());
    }).catchError((error) {
     
      emit(SearchInCategoryErrorState());
    });
  }

 void seachInCategoryWithPrice({
    required int categoryId,
    double? maxPrice,
  }) {
    emit(SearchInCategoryLoadingState());
    DioHelper.postData(
      path: ApiConstant.searchInCategoryPath,
      data: {
        "category_id": categoryId,
        "min_price": 0,
        "max_price": maxPrice,
      },
    ).then((value) {
      serchProduct = ProductDataModel.fromJson(value.data);
      emit(SearchInCategorySuccessState());
    }).catchError((error) {
      
      emit(SearchInCategoryErrorState());
    });
  }

  void changeSliderValue({required double value}) {
    sliderValue = value;
    emit(ChangeSliderValueState());
  }

  void getFirstLoadProduct({required int id}) {
    isFirstLoading = true;
    categoryId = id;
    emit(ProductInCategoryLoadingState());
    isFirstLoading = true;
    DioHelper.getData(
        path: ApiConstant.productInCategoryPath(
          id: id,
        ),
        queryParameters: {
          "page": pageNumber,
        }).then((value) {
      productModel = ProductModel.fromJson(
        value.data,
      );
      productList.addAll(productModel.data.data);
      emit(ProductInCategorySuccessState());
    }).catchError((error) {
      emit(
        ProductInCategoryErrorState(),
      );
    });
    isFirstLoading = false;
    controller.addListener(getLoadMoreProduct);
  }

  ScrollController controller = ScrollController();

  void getLoadMoreProduct() {
    if (hasPages == true && isFirstLoading == false && isMoreLoading == false) {
      isMoreLoading = true;
      pageNumber++;
      DioHelper.getData(
          path: ApiConstant.productInCategoryPath(
            id: categoryId,
          ),
          queryParameters: {
            "page": pageNumber,
          }).then((value) {
        productModel = ProductModel.fromJson(
          value.data,
        );

        productMoreList = [];
        productMoreList.addAll(productModel.data.data);
        if (productMoreList.isNotEmpty) {
          productList.addAll(productMoreList);
        } else {
          hasPages = false;
        }

        isMoreLoading = false;
        emit(ProductInCategorySuccessState());
      }).catchError((error) {
        emit(
          ProductInCategoryErrorState(),
        );
      });
      isMoreLoading == false;
    }
  }
}
