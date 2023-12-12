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
import '../../../model/cart_model.dart';
import '../../cart/controller/bloc.dart';
import '../../cart/controller/states.dart';
import '../../product_details/view/product_details_screen.dart';

class CheckoutScreen extends StatelessWidget {
  const CheckoutScreen({
    super.key,
    required this.name,
    required this.address,
    required this.note,
    required this.phone,
    required this.area,
    required this.coast,
    required this.deliveryAreaId,
  });
  final String name;
  final String phone;
  final String address;
  final String note;
  final String area;
  final String coast;
  final int deliveryAreaId;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CartBloc()..getCart(),
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            AppStrings.confirmation.tr(),
            style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                  color: ColorManager.white,
                ),
          ),
        ),
        body: BlocConsumer<CartBloc, CartStates>(
          listener: (context, state) {
            if (state is CheckoutOrderSuccessState) {
              SharedWidget.toast(
                message: AppStrings.orderMadeSuccessfully.tr(),
                backgroundColor: ColorManager.agree,
              );
              Navigator.pushReplacementNamed(context, Routes.homeRoute);
            }
          },
          builder: (context, state) {
            return Padding(
              padding: EdgeInsetsDirectional.symmetric(
                horizontal: MediaQuery.of(context).size.width / AppSize.s20,
                vertical: MediaQuery.of(context).size.height / AppSize.s80,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsetsDirectional.symmetric(
                      vertical:
                          MediaQuery.of(context).size.height / AppSize.s50,
                      horizontal:
                          MediaQuery.of(context).size.width / AppSize.s60,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadiusDirectional.circular(
                        AppSize.s10.w,
                      ),
                      color: ColorManager.white,
                    ),
                    child: Column(
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              AppStrings.name.tr(),
                              style: Theme.of(context).textTheme.headlineMedium,
                            ),
                            Text(
                              ":",
                              style: Theme.of(context).textTheme.headlineMedium,
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width /
                                  AppSize.s30,
                            ),
                            Expanded(
                              child: Text(
                                name,
                                style:
                                    Theme.of(context).textTheme.headlineLarge,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height:
                              MediaQuery.of(context).size.height / AppSize.s60,
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              AppStrings.phoneNumber.tr(),
                              style: Theme.of(context).textTheme.headlineMedium,
                            ),
                            Text(
                              ":",
                              style: Theme.of(context).textTheme.headlineMedium,
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width /
                                  AppSize.s30,
                            ),
                            Expanded(
                              child: Text(
                                phone,
                                style:
                                    Theme.of(context).textTheme.headlineLarge,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height:
                              MediaQuery.of(context).size.height / AppSize.s60,
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              AppStrings.address.tr(),
                              style: Theme.of(context).textTheme.headlineMedium,
                            ),
                            Text(
                              ":",
                              style: Theme.of(context).textTheme.headlineMedium,
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width /
                                  AppSize.s30,
                            ),
                            Expanded(
                              child: Text(
                                address,
                                style:
                                    Theme.of(context).textTheme.headlineLarge,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height:
                              MediaQuery.of(context).size.height / AppSize.s60,
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              AppStrings.area.tr(),
                              style: Theme.of(context).textTheme.headlineMedium,
                            ),
                            Text(
                              ":",
                              style: Theme.of(context).textTheme.headlineMedium,
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width /
                                  AppSize.s30,
                            ),
                            Expanded(
                              child: Text(
                                area,
                                style:
                                    Theme.of(context).textTheme.headlineLarge,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height:
                              MediaQuery.of(context).size.height / AppSize.s60,
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              AppStrings.deliveryCoast.tr(),
                              style: Theme.of(context).textTheme.headlineMedium,
                            ),
                            Text(
                              ":",
                              style: Theme.of(context).textTheme.headlineMedium,
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width /
                                  AppSize.s30,
                            ),
                            Expanded(
                              child: Text(
                                coast,
                                style:
                                    Theme.of(context).textTheme.headlineLarge,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height:
                              MediaQuery.of(context).size.height / AppSize.s60,
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              AppStrings.note.tr(),
                              style: Theme.of(context).textTheme.headlineMedium,
                            ),
                            Text(
                              ":",
                              style: Theme.of(context).textTheme.headlineMedium,
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width /
                                  AppSize.s30,
                            ),
                            Expanded(
                              child: Text(
                                note,
                                style:
                                    Theme.of(context).textTheme.headlineLarge,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height / AppSize.s50,
                  ),
                  Text(
                    AppStrings.orderDetails.tr(),
                    style: Theme.of(context).textTheme.headlineLarge,
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height / AppSize.s50,
                  ),
                  Expanded(
                    child: ListView.separated(
                      itemBuilder: (context, index) => cartItem(
                        model: CartBloc.get(context).cartModel.data[index],
                        context: context,
                      ),
                      separatorBuilder: (context, index) => SizedBox(
                        height:
                            MediaQuery.of(context).size.height / AppSize.s60,
                      ),
                      itemCount: CartBloc.get(context).cartModel.data.length,
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height / AppSize.s50,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        AppStrings.totalPrice.tr(),
                        style: Theme.of(context).textTheme.headlineMedium,
                      ),
                      Text(
                        "${CartBloc.get(context).totalPrice(deliveryCoast: double.parse(coast))}",
                        style: Theme.of(context).textTheme.headlineMedium,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height / AppSize.s50,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        AppStrings.deliveryMethod.tr(),
                        style: Theme.of(context).textTheme.headlineMedium,
                      ),
                      Text(
                        AppStrings.cashOnDelivery.tr(),
                        style: Theme.of(context).textTheme.headlineMedium,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height / AppSize.s50,
                  ),
                  state is CheckoutOrderLoadingState
                      ? const Center(
                          child: CircularProgressIndicator(),
                        )
                      : SharedWidget.defaultButton(
                          label: AppStrings.confirmation.tr(),
                          context: context,
                          width: double.infinity,
                          onPressed: () {
                            CartBloc.get(context).checkoutOrder(
                              name: name,
                              address: address,
                              phone: phone,
                              note: note,
                              deliveryAreaId: deliveryAreaId,
                            );
                          },
                        ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height / AppSize.s60,
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
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
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal:
                          MediaQuery.of(context).size.width / AppSize.s50),
                  child: Text(
                    "${model.quantity}",
                    style: Theme.of(context).textTheme.headlineLarge,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
