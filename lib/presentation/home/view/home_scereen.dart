// ignore_for_file: must_be_immutable

import 'package:carousel_slider/carousel_slider.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../app/common/widget.dart';
import '../../../app/resources/assets_manager.dart';
import '../../../app/resources/color_manager.dart';
import '../../../app/resources/routes_manager.dart';
import '../../../app/resources/strings_manager.dart';
import '../../../app/resources/values_manager.dart';
import '../../../app/services/shared_prefrences/cache_helper.dart';
import '../../../model/category_model.dart';
import '../../product_in_category/view/product_in_category_screen.dart';
import '../controller/bloc.dart';
import '../controller/states.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeBloc()
        ..getBanner()
        ..getCategories()
        ..getFirstLoadProduct()
      // ..getAllProducts()
      ,
      child: BlocBuilder<HomeBloc, HomeStates>(
        builder: (context, state) {
          return Scaffold(
            body: SafeArea(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                controller: HomeBloc.get(context).controller,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal:
                            MediaQuery.of(context).size.width / AppSize.s50,
                        vertical:
                            MediaQuery.of(context).size.height / AppSize.s50,
                      ),
                      child: Row(
                        children: [
                          CircleAvatar(
                            radius:
                                MediaQuery.of(context).size.width / AppSize.s12,
                            backgroundColor: ColorManager.primaryColor,
                            backgroundImage: const AssetImage(
                              AssetsManager.logo,
                            ),
                          ),
                          const Spacer(),
                          InkWell(
                            onTap: () {
                              if (CacheHelper.getData(key: SharedKey.token) !=
                                  null) {
                                Navigator.pushNamed(
                                  context,
                                  Routes.cartRoute,
                                );
                              } else {
                                Navigator.pushNamed(
                                  context,
                                  Routes.loginRoute,
                                );
                              }
                            },
                            child: const Icon(
                              Icons.shopping_cart_outlined,
                              color: ColorManager.yellow,
                            ),
                          ),
                          SizedBox(
                            width:
                                MediaQuery.of(context).size.width / AppSize.s50,
                          ),
                          InkWell(
                            onTap: () {
                              if (CacheHelper.getData(key: SharedKey.token) !=
                                  null) {
                                Navigator.pushNamed(
                                  context,
                                  Routes.favoriteRoute,
                                );
                              } else {
                                Navigator.pushNamed(
                                  context,
                                  Routes.loginRoute,
                                );
                              }
                            },
                            child: const Icon(
                              Icons.favorite_outline,
                              color: ColorManager.yellow,
                            ),
                          ),
                          SizedBox(
                            width:
                                MediaQuery.of(context).size.width / AppSize.s50,
                          ),
                          InkWell(
                            onTap: () {
                              if (CacheHelper.getData(key: SharedKey.token) !=
                                  null) {
                                Navigator.pushNamed(
                                  context,
                                  Routes.profileRoute,
                                );
                              } else {
                                Navigator.pushNamed(
                                  context,
                                  Routes.loginRoute,
                                );
                              }
                            },
                            child: const Icon(
                              Icons.person_2_outlined,
                              color: ColorManager.yellow,
                            ),
                          ),
                        ],
                      ),
                    ),

                    /// Banners
                    SizedBox(
                      height: MediaQuery.of(context).size.height / AppSize.s50,
                    ),

                    Visibility(
                      visible: HomeBloc.get(context).banners.isNotEmpty,
                      child: CarouselSlider(
                        items: HomeBloc.get(context)
                            .banners
                            .map(
                              (e) => Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(
                                    AppSize.s20.r,
                                  ),
                                  image: DecorationImage(
                                    image: NetworkImage(e),
                                    fit: BoxFit.fill,
                                  ),
                                ),
                              ),
                            )
                            .toList(),
                        options: CarouselOptions(
                          animateToClosest: true,
                          autoPlay: true,
                          initialPage: 0,
                          // enlargeStrategy: CenterPageEnlargeStrategy.height,
                          enlargeCenterPage: true,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height / AppSize.s50,
                    ),

                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal:
                            MediaQuery.of(context).size.width / AppSize.s50,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            AppStrings.category.tr(),
                            style: Theme.of(context).textTheme.headlineLarge,
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.pushNamed(
                                context,
                                Routes.categoryRoute,
                              );
                            },
                            child: Text(
                              AppStrings.seeAll.tr(),
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .copyWith(
                                    decoration: TextDecoration.underline,
                                  ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height / AppSize.s100,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal:
                            MediaQuery.of(context).size.width / AppSize.s50,
                      ),
                      child: SizedBox(
                        height: AppSize.s80.h,
                        child:
                            HomeBloc.get(context).categoryModel.data.isNotEmpty
                                ? categoryItem(
                                    model: HomeBloc.get(context).categoryModel,
                                  )
                                : const Center(
                                    child: CircularProgressIndicator(
                                      color: ColorManager.primaryColor,
                                    ),
                                  ),
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height / AppSize.s100,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal:
                            MediaQuery.of(context).size.width / AppSize.s50,
                      ),
                      child: Text(
                        AppStrings.newProduct.tr(),
                        style: Theme.of(context).textTheme.headlineLarge,
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height / AppSize.s100,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal:
                            MediaQuery.of(context).size.width / AppSize.s50,
                      ),
                      child: HomeBloc.get(context).productList.isNotEmpty
                          ? GridView.builder(
                              padding: EdgeInsets.all(5.w),
                              shrinkWrap: true,
                              itemCount:
                                  HomeBloc.get(context).productList.length,
                              physics: const NeverScrollableScrollPhysics(),
                              itemBuilder: (context, index) {
                                return SharedWidget.productItem(
                                  context: context,
                                  model:
                                      HomeBloc.get(context).productList[index],
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
                          : Padding(
                              padding: EdgeInsets.symmetric(
                                vertical: MediaQuery.of(context).size.height /
                                    AppSize.s50,
                              ),
                              child: Center(
                                child: Text(
                                  AppStrings.notFoundProduct.tr(),
                                  style: Theme.of(context).textTheme.titleSmall,
                                ),
                              ),
                            ),
                    ),
                    if (HomeBloc.get(context).isMoreLoading)
                      Padding(
                        padding: EdgeInsets.symmetric(
                          vertical:
                              MediaQuery.of(context).size.height / AppSize.s50,
                        ),
                        child: const Center(
                          child: CircularProgressIndicator(
                            color: ColorManager.primaryColor,
                          ),
                        ),
                      ),
                    if (HomeBloc.get(context).hasPages == false)
                      Padding(
                        padding: EdgeInsets.symmetric(
                          vertical:
                              MediaQuery.of(context).size.height / AppSize.s50,
                        ),
                        child: Center(
                          child: Text(
                            AppStrings.notFoundOtherProduct.tr(),
                            style: Theme.of(context).textTheme.titleSmall,
                          ),
                        ),
                      ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height / AppSize.s50,
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget categoryItem({
    required CategoryModel model,
  }) =>
      ListView.separated(
        physics: const BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) => InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ProductInCategoryScreen(
                  id: model.data[index].id,
                  categoryName: model.data[index].name,
                ),
              ),
            );
          },
          child: Container(
            width: AppSize.s72.w,
            decoration: BoxDecoration(
              color: ColorManager.yellow,
              image: DecorationImage(
                image: NetworkImage(model.data[index].image),
                fit: BoxFit.fill,
              ),
              shape: BoxShape.circle,
            ),
          ),
        ),
        separatorBuilder: (context, index) => SizedBox(
          width: MediaQuery.of(context).size.width / AppSize.s50,
        ),
        itemCount: model.data.length,
      );
}
