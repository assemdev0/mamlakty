import 'package:conditional_builder_rec/conditional_builder_rec.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mamlakty/app/constant/enums_extentions.dart';
import '../../../app/common/widget.dart';
import '../../../app/resources/color_manager.dart';
import '../../../app/resources/routes_manager.dart';
import '../../../app/resources/strings_manager.dart';
import '../../../app/resources/values_manager.dart';
import '../../../app/services/shared_prefrences/cache_helper.dart';
import '../../../model/product_model.dart';
import '../../product_details/controller/bloc.dart';
import '../../product_details/controller/states.dart';
import '../../product_details/view/product_details_screen.dart';
import '../controller/bloc.dart';
import '../controller/states.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppStrings.favorites.tr(),
          style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                color: ColorManager.white,
              ),
        ),
      ),
      body: BlocProvider(
        create: (context) => FavoritesBloc()..getFavorites(),
        child: BlocBuilder<FavoritesBloc, FavoritesStates>(
          builder: (context, state) {
            return Padding(
              padding: EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).size.width / AppSize.s40,
                vertical: MediaQuery.of(context).size.width / AppSize.s50,
              ),
              child: ConditionalBuilderRec(
                condition: state is FavoriteSuccessState ||
                    state is RemoveFromFavoritesSuccessState,
                builder: (context) => GridView.builder(
                  itemCount:
                      FavoritesBloc.get(context).favoritesModel.data.length,
                  physics: const BouncingScrollPhysics(),
                  itemBuilder: (context, index) {
                    return productFavItem(
                      context: context,
                      model: FavoritesBloc.get(context)
                          .favoritesModel
                          .data[index]
                          .productDataModel,
                    );
                  },
                  semanticChildCount: 2,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: AppSize.s20.w,
                    crossAxisSpacing: AppSize.s20.h,
                    childAspectRatio: 1 / 1.3,
                  ),
                ),
                fallback: (context) => const Center(
                  child: CircularProgressIndicator(
                      color: ColorManager.primaryColor),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget productFavItem({
    required BuildContext context,
    required DataModel model,
  }) =>
      BlocProvider(
        create: (context) => ProductDetailsBloc(),
        child: BlocConsumer<ProductDetailsBloc, ProductDetailsStates>(
          listener: (context, state) {
            if (state is AddToCartSuccessState) {
              SharedWidget.toast(
                message: AppStrings.productAddedToCart.tr(),
                backgroundColor: ColorManager.agree,
              );
            } else if (state is RemoveFromFavoritesSuccessState) {
              SharedWidget.toast(
                message: AppStrings.productRemovedFromFavorites.tr(),
                backgroundColor: ColorManager.agree,
              );
              FavoritesBloc.get(context).getFavorites();
            }
          },
          builder: (context, state) {
            return InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ProductDetailsScreen(
                      id: model.id,
                      name: model.name,
                      categoryId: model.category.id,
                    ),
                  ),
                );
              },
              child: Container(
                clipBehavior: Clip.antiAliasWithSaveLayer,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: ColorManager.grey,
                  ),
                  borderRadius: BorderRadius.circular(
                    AppSize.s20,
                  ),
                ),
                width: AppSize.s250.w,
                child: Column(
                  children: [
                    Expanded(
                      flex: 3,
                      child: model.images.isEmpty
                          ? Container(
                              color: ColorManager.grey,
                            )
                          : Container(
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: NetworkImage(
                                    model.images[0].image,
                                  ),
                                  fit: BoxFit.fill,
                                ),
                              ),
                            ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal:
                              MediaQuery.of(context).size.width / AppSize.s50,
                          vertical:
                              MediaQuery.of(context).size.height / AppSize.s80,
                        ),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Text(
                                    model.name.toTitleCase(),
                                    style: Theme.of(context)
                                        .textTheme
                                        .headlineMedium,
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
                                    if (CacheHelper.getData(
                                            key: SharedKey.token) !=
                                        null) {
                                      ProductDetailsBloc.get(context)
                                          .removeFromFavorites(
                                              productId: model.id);
                                    } else {
                                      Navigator.pushNamed(
                                          context, Routes.loginRoute);
                                    }
                                  },
                                  child: const Icon(
                                    Icons.favorite,
                                    color: ColorManager.yellow,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height /
                                  AppSize.s120,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  flex: 1,
                                  child: Text(
                                    model.price,
                                    style: Theme.of(context)
                                        .textTheme
                                        .headlineLarge!
                                        .copyWith(
                                          color: ColorManager.yellow,
                                        ),
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
                                    if (CacheHelper.getData(
                                            key: SharedKey.token) !=
                                        null) {
                                      ProductDetailsBloc.get(context)
                                          .addToCart(productId: model.id);
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
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      );
}
