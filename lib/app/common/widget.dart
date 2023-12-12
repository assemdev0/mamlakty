import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mamlakty/app/constant/enums_extentions.dart';
import '../../model/product_model.dart';
import '../../presentation/product_details/controller/bloc.dart';
import '../../presentation/product_details/controller/states.dart';
import '../../presentation/product_details/view/product_details_screen.dart';
import '../resources/color_manager.dart';
import '../resources/font_manager.dart';
import '../resources/language_manager.dart';
import '../resources/routes_manager.dart';
import '../resources/strings_manager.dart';
import '../resources/values_manager.dart';
import '../services/shared_prefrences/cache_helper.dart';

class SharedWidget {
  static Widget defaultButton({
    required String label,
    required BuildContext context,
    required double width,
    required Function() onPressed,
    double height = AppSize.s40,
    Color background = ColorManager.primaryColor,
    Color labelColor = ColorManager.white,
    double raidus = AppSize.s10,
  }) =>
      Container(
        width: width,
        height: height.h,
        decoration: BoxDecoration(
          borderRadius: BorderRadiusDirectional.circular(
            raidus,
          ),
        ),
        clipBehavior: Clip.antiAliasWithSaveLayer,
        child: MaterialButton(
          color: background,
          onPressed: onPressed,
          child: Text(
            label,
            style: Theme.of(context).textTheme.displayMedium!.copyWith(
                  color: labelColor,
                ),
          ),
        ),
      );

  static Widget defaultTextFormField(
          {required TextEditingController controller,
          required TextInputType textInputType,
          required BuildContext context,
          bool obscure = false,
          String? Function(String?)? validator,
          void Function(String)? onFieldSubmitted,
          Function()? onTap,
          Function(String value)? onChanged,
          String? hint,
          Widget? suffixIcon,
          Widget? prefixIcon,
          int maxLines = 1,
          TextStyle? textStyle}) =>
      TextFormField(
        onTap: onTap,
        onFieldSubmitted: onFieldSubmitted,
        style: Theme.of(context).textTheme.headlineMedium,
        obscureText: obscure,
        cursorColor: ColorManager.primaryColor,
        onChanged: onChanged,
        decoration: InputDecoration(
          hintText: hint,
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: ColorManager.primaryColor,
            ),
            borderRadius: BorderRadius.circular(
              AppSize.s10,
            ),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(
              AppSize.s10,
            ),
          ),
          hintStyle: Theme.of(context).textTheme.bodySmall,
          contentPadding: EdgeInsetsDirectional.only(
            start: MediaQuery.of(context).size.width / AppSize.s16,
          ),
          suffixIcon: suffixIcon,
          prefixIcon: prefixIcon,
        ),
        validator: validator,
        controller: controller,
        keyboardType: textInputType,
        maxLines: maxLines,
      );

  static Widget productItem({
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
            } else if (state is AddToFavoritesSuccessState) {
              SharedWidget.toast(
                message: AppStrings.productAddedToFavorites.tr(),
                backgroundColor: ColorManager.agree,
              );
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
                                          .addToFavorites(productId: model.id);
                                    } else {
                                      Navigator.pushNamed(
                                          context, Routes.loginRoute);
                                    }
                                  },
                                  child: const Icon(
                                    Icons.favorite_border_outlined,
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

  static void changeLanguage(context) {
    changeAppLanguage();
    Phoenix.rebirth(context);
  }

  static toast({required String message, required Color backgroundColor}) {
    return Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: backgroundColor,
      textColor: ColorManager.white,
      fontSize: FontSizeManager.s14.sp,
    );
  }
}
