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
import '../../../model/cart_model.dart';
import '../../product_details/view/product_details_screen.dart';
import '../controller/bloc.dart';
import '../controller/states.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => CartBloc()..getCart(),
        child: BlocBuilder<CartBloc, CartStates>(
          builder: (context, state) {
            return Scaffold(
              appBar: AppBar(
                title: Text(
                  AppStrings.myCart.tr(),
                  style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                        color: ColorManager.white,
                      ),
                ),
              ),
              body: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: MediaQuery.of(context).size.width / AppSize.s50,
                  vertical: MediaQuery.of(context).size.height / AppSize.s60,
                ),
                child: Column(
                  children: [
                    Expanded(
                      child: CartBloc.get(context).cartModel.data.isNotEmpty
                          ? ConditionalBuilderRec(
                              condition:
                                  state is IncrementProductCounterState ||
                                      state is DecrementProductCounterState ||
                                      state is CartSuccessState ||
                                      state is EditCartSuccessState,
                              builder: (context) {
                                return ListView.separated(
                                  itemBuilder: (context, index) => cartItem(
                                    model: CartBloc.get(context)
                                        .cartModel
                                        .data[index],
                                    context: context,
                                  ),
                                  separatorBuilder: (context, index) =>
                                      SizedBox(
                                    height: MediaQuery.of(context).size.height /
                                        AppSize.s60,
                                  ),
                                  itemCount: CartBloc.get(context)
                                      .cartModel
                                      .data
                                      .length,
                                );
                              },
                              fallback: (context) => const Center(
                                child: CircularProgressIndicator(
                                    color: ColorManager.primaryColor),
                              ),
                            )
                          : Center(
                              child: Text(
                                AppStrings.notFoundProduct.tr(),
                                style: Theme.of(context).textTheme.titleSmall,
                              ),
                            ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height / AppSize.s60,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal:
                            MediaQuery.of(context).size.width / AppSize.s50,
                      ),
                      child: Row(
                        children: [
                          Text(
                            AppStrings.totalPrice.tr(),
                            style: Theme.of(context)
                                .textTheme
                                .headlineMedium!
                                .copyWith(color: ColorManager.yellow),
                          ),
                          const Spacer(),
                          Text(
                            "${CartBloc.get(context).totalPrice()}",
                            style: Theme.of(context)
                                .textTheme
                                .headlineLarge!
                                .copyWith(
                                  color: ColorManager.yellow,
                                ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height / AppSize.s60,
                    ),
                    SharedWidget.defaultButton(
                      label: AppStrings.goToCheckout.tr(),
                      context: context,
                      width: double.infinity,
                      onPressed: () {
                        if (CartBloc.get(context).cartModel.data.isNotEmpty) {
                          Navigator.pushNamed(
                            context,
                            Routes.registerRoute,
                          );
                        }
                      },
                    ),
                  ],
                ),
              ),
            );
          },
        ));
  }

  Widget cartItem(
      {required BuildContext context, required CartDataModel model}) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProductDetailsScreen(
              id: model.productDataModel.id,
              name: model.productDataModel.name,
              categoryId: model.productDataModel.category.id,
            ),
          ),
        );
      },
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 1,
            child: Container(
              height: AppSize.s100.h,
              decoration: BoxDecoration(
                color: ColorManager.primaryColor,
                image: model.productDataModel.images.isNotEmpty
                    ? DecorationImage(
                        image: NetworkImage(
                            model.productDataModel.images[0].image),
                        fit: BoxFit.fill)
                    : null,
                borderRadius: BorderRadius.circular(
                  AppSize.s8.w,
                ),
              ),
            ),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width / AppSize.s50,
          ),
          Expanded(
            flex: 2,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  model.productDataModel.name.toTitleCase(),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context)
                      .textTheme
                      .headlineMedium!
                      .copyWith(color: ColorManager.yellow),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height / AppSize.s60,
                ),
                Text(
                  model.productDataModel.price,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                        color: ColorManager.yellow,
                      ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height / AppSize.s60,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    InkWell(
                      onTap: () {
                        model.quantity++;
                        CartBloc.get(context).incrementProductCounter();
                        CartBloc.get(context).editCart(
                            productId: model.productDataModel.id,
                            quantity: model.quantity);
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
                              MediaQuery.of(context).size.width / AppSize.s50),
                      child: Text(
                        "${model.quantity}",
                        style: Theme.of(context).textTheme.headlineLarge,
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        if (model.quantity <= 1) {
                          model.quantity = 1;
                        } else {
                          model.quantity--;
                        }
                        CartBloc.get(context).decrementProductCounter();
                        CartBloc.get(context).editCart(
                            productId: model.productDataModel.id,
                            quantity: model.quantity);
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
                )
              ],
            ),
          ),
          Align(
            alignment: AlignmentDirectional.topStart,
            child: IconButton(
              icon: const Icon(Icons.close),
              onPressed: () {
                CartBloc.get(context).editCart(
                  productId: model.productDataModel.id,
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
