import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../app/constant/api_constant.dart';
import '../../../app/services/dio_helper/dio_helper.dart';
import '../../../model/banner_model.dart';
import '../../../model/category_model.dart';
import '../../../model/product_model.dart';
import 'states.dart';

class HomeBloc extends Cubit<HomeStates> {
  HomeBloc() : super(HomeInitState());

  static HomeBloc get(context) => BlocProvider.of(context);
  BannerModel bannerModel = BannerModel();
  List<String> banners = [];

  void getBanner() {
    emit(BannerLoadingState());
    DioHelper.getData(path: ApiConstant.bannerPath).then((value) {
      bannerModel = BannerModel.fromJson(value.data);
      log("Banners: ${value.toString()}");
      for (var element in bannerModel.data) {
        banners.add(element.image);
      }
      emit(BannerSuccessState());
    }).catchError((error) {
      log(error.toString());
      emit(BannerErrorState());
    });
  }

  CategoryModel categoryModel = CategoryModel();

  void getCategories() {
    emit(CategoryLoadingState());
    DioHelper.getData(
      path: ApiConstant.categoriesPath,
    ).then((value) {
      categoryModel = CategoryModel.fromJson(value.data);
      emit(CategorySuccessState());
    }).catchError((error) {
      log(error.toString());

      emit(CategoryErrorState());
    });
  }

  int pageNumber = 1;
  bool isFirstLoading = false;
  bool hasPages = true;
  bool isMoreLoading = false;

  ProductModel productModel = ProductModel();
  List<DataModel> productList = [];
  List<DataModel> productMoreList = [];

  void getFirstLoadProduct() {
    isFirstLoading = true;
    emit(NewProductLoadingState());
    isFirstLoading = true;
    DioHelper.getData(path: ApiConstant.newProductPath, queryParameters: {
      "page": pageNumber,
    }).then((value) {
      productModel = ProductModel.fromJson(
        value.data,
      );
      log(value.toString());
      productList.addAll(productModel.data.data);
      emit(NewProductSuccessState());
    }).catchError((error) {
      log(error.toString());

      emit(NewProductErrorState());
    });
    isFirstLoading = false;
    controller.addListener(getLoadMoreProduct);
  }

  ScrollController controller = ScrollController();

  void getLoadMoreProduct() {
    if (hasPages == true && isFirstLoading == false && isMoreLoading == false) {
      isMoreLoading = true;
      pageNumber++;
      DioHelper.getData(path: ApiConstant.newProductPath, queryParameters: {
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
        emit(NewProductSuccessState());
      }).catchError((error) {
        emit(
          NewProductErrorState(),
        );
      });
      isMoreLoading == false;
    }
  }

  /// get all products in all categories
/*
  getAllProducts() {
    emit(GetAllProductsLoadingState());
    for (var element in categoryModel.data) {
      DioHelper.getData(
        path: ApiConstant.productInCategoryPath(
          id: element.id,
        ),
      ).then((value) {
        productModel = ProductModel.fromJson(
          value.data,
        );
        productList.addAll(productModel.data.data);
      }).catchError((error) {
        emit(GetAllProductsErrorState());
      });
    }
    log("all products: ${productList.length}");
    emit(GetAllProductsSuccessState());
  }
*/
}
