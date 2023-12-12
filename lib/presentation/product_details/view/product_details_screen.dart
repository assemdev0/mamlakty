import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder_rec/conditional_builder_rec.dart';
import 'package:easy_localization/easy_localization.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mamlakty/app/constant/enums_extentions.dart';
import '../../../app/common/widget.dart';
import '../../../app/resources/color_manager.dart';
import '../../../app/resources/font_manager.dart';
import '../../../app/resources/routes_manager.dart';
import '../../../app/resources/strings_manager.dart';
import '../../../app/resources/values_manager.dart';
import '../../../app/services/shared_prefrences/cache_helper.dart';
import '../controller/bloc.dart';
import '../controller/states.dart';

class ProductDetailsScreen extends StatelessWidget {
  const ProductDetailsScreen({
    super.key,
    required this.id,
    required this.name,
    required this.categoryId,
  });
  final int id;
  final int categoryId;
  final String name;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProductDetailsBloc()
        ..getProductDetails(id: id)
        ..getSimilarProducts(
          id: categoryId,
        ),
      child: BlocConsumer<ProductDetailsBloc, ProductDetailsStates>(
        listener: (context, state) {
          if (state is AddToCartSuccessState) {
            SharedWidget.toast(
              message: AppStrings.productAddedToCart.tr(),
              backgroundColor: ColorManager.agree,
            );
          } else if (state is AddToFavoritesSuccessState) {
            SharedWidget.toast(
              message: AppStrings.productAddedToFavorites.tr(),
              backgroundColor: ColorManager.agree,
            );
          }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              title: Text(
                name.toTitleCase(),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                      color: ColorManager.white,
                    ),
              ),
            ),
            body: SingleChildScrollView(
              child: ConditionalBuilderRec(
                condition: state is ProductDetailsSuccessState ||
                    state is IncrementProductCounterState ||
                    state is DecrementProductCounterState ||
                    state is SimilarProductSuccessState ||
                    state is AddToCartSuccessState ||
                    state is AddToFavoritesSuccessState,
                builder: (context) {
                  return Column(
                    children: [
                      SizedBox(
                        height:
                            MediaQuery.of(context).size.height / AppSize.s80,
                      ),
                      sliderBanner(
                        banners: ProductDetailsBloc.get(context).banners,
                      ),
                      SizedBox(
                        height:
                            MediaQuery.of(context).size.height / AppSize.s50,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal:
                              MediaQuery.of(context).size.width / AppSize.s30,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              ProductDetailsBloc.get(context)
                                  .productDetailsModel
                                  .data
                                  .name,
                              style: Theme.of(context)
                                  .textTheme
                                  .headlineLarge,
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height /
                                  AppSize.s50,
                            ),
                            Text(
                              ProductDetailsBloc.get(context)
                                  .productDetailsModel
                                  .data
                                  .description,
                              style: Theme.of(context)
                                  .textTheme
                                  .displaySmall!
                                  .copyWith(color: ColorManager.grey),
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height /
                                  AppSize.s50,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  ProductDetailsBloc.get(context)
                                      .productDetailsModel
                                      .data
                                      .price,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: Theme.of(context)
                                      .textTheme
                                      .headlineLarge!
                                      .copyWith(
                                        color: ColorManager.yellow,
                                      ),
                                ),
                                InkWell(
                                  onTap: () {
                                    if (CacheHelper.getData(
                                            key: SharedKey.token) !=
                                        null) {
                                      ProductDetailsBloc.get(context)
                                          .addToFavorites(
                                        productId: id,
                                      );
                                    } else {
                                      Navigator.pushNamed(
                                        context,
                                        Routes.loginRoute,
                                      );
                                    }
                                  },
                                  child: const Icon(
                                    Icons.favorite_border_outlined,
                                    color: ColorManager.yellow,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height /
                                  AppSize.s50,
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: SharedWidget.defaultButton(
                                    label: AppStrings.addToCart.tr(),
                                    context: context,
                                    width: double.infinity,
                                    onPressed: () {
                                      if (CacheHelper.getData(
                                              key: SharedKey.token) ==
                                          null) {
                                        Navigator.pushNamed(
                                          context,
                                          Routes.loginRoute,
                                        );
                                      } else {
                                        ProductDetailsBloc.get(context)
                                            .addToCart(
                                          productId: id,
                                        );
                                      }
                                    },
                                  ),
                                ),
                                SizedBox(
                                  width: MediaQuery.of(context).size.width /
                                      AppSize.s30,
                                ),
                                InkWell(
                                  onTap: () {
                                    ProductDetailsBloc.get(context)
                                        .incrementProductCounter();
                                  },
                                  child: CircleAvatar(
                                    radius: AppSize.s18.w,
                                    backgroundColor: ColorManager.primaryColor,
                                    child: Text(
                                      "+",
                                      style: Theme.of(context)
                                          .textTheme
                                          .displaySmall!
                                          .copyWith(
                                            color: ColorManager.white,
                                            fontSize: FontSizeManager.s18.sp,
                                          ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal:
                                          MediaQuery.of(context).size.width /
                                              AppSize.s50),
                                  child: Text(
                                    "${ProductDetailsBloc.get(context).productCounter}",
                                    style: Theme.of(context)
                                        .textTheme
                                        .headlineLarge,
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
                                    ProductDetailsBloc.get(context)
                                        .decrementProductCounter();
                                  },
                                  child: CircleAvatar(
                                    radius: AppSize.s18.w,
                                    backgroundColor: ColorManager.primaryColor,
                                    child: Text(
                                      "-",
                                      style: Theme.of(context)
                                          .textTheme
                                          .displaySmall!
                                          .copyWith(
                                            fontSize: FontSizeManager.s18.sp,
                                            color: ColorManager.white,
                                          ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height /
                                  AppSize.s40,
                            ),
                            Text(
                              AppStrings.similarProducts.tr(),
                              style: Theme.of(context)
                                  .textTheme
                                  .headlineLarge!
                                  .copyWith(
                                    color: ColorManager.yellow,
                                  ),
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height /
                                  AppSize.s60,
                            ),
                            ProductDetailsBloc.get(context)
                                    .productModel
                                    .data
                                    .data
                                    .isNotEmpty
                                ? GridView.builder(
                                    shrinkWrap: true,
                                    itemCount: ProductDetailsBloc.get(context)
                                        .productModel
                                        .data
                                        .data
                                        .length,
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    itemBuilder: (context, index) {
                                      return SharedWidget.productItem(
                                        context: context,
                                        model: ProductDetailsBloc.get(context)
                                            .productModel
                                            .data
                                            .data[index],
                                      );
                                    },
                                    semanticChildCount: 2,
                                    gridDelegate:
                                        SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2,
                                      mainAxisSpacing: AppSize.s20.w,
                                      crossAxisSpacing: AppSize.s20.h,
                                      childAspectRatio: 1 / 1.3,
                                    ),
                                  )
                                : Center(
                                    child: Text(
                                      AppStrings.notFoundProduct.tr(),
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleSmall,
                                    ),
                                  ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height /
                                  AppSize.s50,
                            ),
                          ],
                        ),
                      ),
                    ],
                  );
                },
                fallback: (context) => Padding(
                  padding: EdgeInsets.symmetric(
                      vertical:
                          MediaQuery.of(context).size.height / AppSize.s3),
                  child: const Center(
                    child: CircularProgressIndicator(
                      color: ColorManager.primaryColor,
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget sliderBanner({required List<String> banners}) => CarouselSlider(
        carouselController: CarouselController(),
        items: banners
            .map(
              (e) => Container(
                decoration: BoxDecoration(
                  color: ColorManager.yellow,
                  borderRadius: BorderRadius.circular(
                    AppSize.s10,
                  ),
                  image: DecorationImage(
                    image: NetworkImage(
                      e,
                    ),
                    fit: BoxFit.fill,
                  ),
                ),
              ),
            )
            .toList(),
        options: CarouselOptions(
          height: AppSize.s120.h,
          viewportFraction: .8,
          initialPage: 0,
          enableInfiniteScroll: true,
          reverse: false,
          autoPlay: true,
          autoPlayInterval: const Duration(
            seconds: AppIntDuration.duration3,
          ),
          autoPlayAnimationDuration: const Duration(
            milliseconds: AppIntDuration.duration500,
          ),
          autoPlayCurve: Curves.fastOutSlowIn,
          enlargeCenterPage: true,
          scrollDirection: Axis.horizontal,
        ),
      );
}
