// ignore_for_file: must_be_immutable, library_prefixes

import 'package:conditional_builder_rec/conditional_builder_rec.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mamlakty/app/constant/enums_extentions.dart';
import '../../../../app/resources/strings_manager.dart';
import '../../../../app/resources/values_manager.dart';
import '../../../app/resources/assets_manager.dart';
import '../../../app/resources/color_manager.dart';
import '../../../model/orders_model.dart';
import '../../order_details/view/order_details_screen.dart';
import '../controller/bloc.dart';
import '../controller/states.dart';

class OrdersScreen extends StatelessWidget {
  const OrdersScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => OrderBloc()..getOrders(),
      child: Scaffold(
          appBar: AppBar(
            title: Text(
              AppStrings.orderHistory.tr(),
              style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                    color: ColorManager.white,
                  ),
            ),
          ),
          body: BlocBuilder<OrderBloc, OrdersStates>(
            builder: (context, state) {
              return Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: MediaQuery.of(context).size.width / AppSize.s30,
                  vertical: MediaQuery.of(context).size.height / AppSize.s80,
                ),
                child: Column(
                  children: [
                    Expanded(
                      child: OrderBloc.get(context).ordersModel.data.isNotEmpty
                          ? ConditionalBuilderRec(
                              condition: state is OrdersSuccessState,
                              builder: (context) {
                                return ListView.separated(
                                  physics: const BouncingScrollPhysics(),
                                  itemBuilder: (context, index) => orderItem(
                                    model: OrderBloc.get(context)
                                        .ordersModel
                                        .data[index],
                                    context: context,
                                  ),
                                  separatorBuilder: (context, index) => Padding(
                                    padding: EdgeInsets.symmetric(
                                      horizontal:
                                          MediaQuery.of(context).size.width /
                                              AppSize.s30,
                                      vertical:
                                          MediaQuery.of(context).size.height /
                                              AppSize.s50,
                                    ),
                                    child: Container(
                                      color: ColorManager.primaryColor,
                                      width: double.infinity,
                                      height: AppSize.s1,
                                    ),
                                  ),
                                  itemCount: OrderBloc.get(context)
                                      .ordersModel
                                      .data
                                      .length,
                                );
                              },
                              fallback: (context) {
                                return const Center(
                                    child: CircularProgressIndicator(
                                  color: ColorManager.primaryColor,
                                ));
                              },
                            )
                          : Center(
                              child: Text(
                                AppStrings.notFound.tr(),
                                style: Theme.of(context).textTheme.titleSmall,
                              ),
                            ),
                    ),
                  ],
                ),
              );
            },
          )),
    );
  }

  Widget orderItem({
    required BuildContext context,
    required OrdersDataModel model,
  }) =>
      InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => OrderDetailsScreen(
                ordersDataModel: model,
              ),
            ),
          );
        },
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: MediaQuery.of(context).size.width / AppSize.s30,
            vertical: MediaQuery.of(context).size.height / AppSize.s50,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Image(
                    image: AssetImage(
                      AssetsManager.shopBag,
                    ),
                    color: ColorManager.yellow,
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width / AppSize.s30,
                  ),
                  Text(
                    model.status.toTitleCase(),
                    style: Theme.of(context).textTheme.headlineLarge,
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsetsDirectional.only(
                  start: MediaQuery.of(context).size.width / AppSize.s14,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height / AppSize.s50,
                    ),
                    Text(
                      DateFormat("dd-MM-yyyy")
                          .format(DateTime.parse(model.createdAt)),
                      style:
                          Theme.of(context).textTheme.headlineMedium!.copyWith(
                                color: ColorManager.yellow,
                              ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height / AppSize.s80,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          AppStrings.totalPrice.tr(),
                          style: Theme.of(context).textTheme.headlineLarge,
                        ),
                        Text(
                          " :",
                          style: Theme.of(context).textTheme.headlineLarge,
                        ),
                        SizedBox(
                          width:
                              MediaQuery.of(context).size.width / AppSize.s40,
                        ),
                        Expanded(
                          child: Text(
                            "EGP ${model.totalPrice}",
                            style: Theme.of(context).textTheme.headlineMedium,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height / AppSize.s80,
                    ),
                    Row(
                      children: [
                        Text(
                          AppStrings.deliveryCoast.tr(),
                          style: Theme.of(context).textTheme.headlineLarge,
                        ),
                        Text(
                          " :",
                          style: Theme.of(context).textTheme.headlineLarge,
                        ),
                        SizedBox(
                          width:
                              MediaQuery.of(context).size.width / AppSize.s40,
                        ),
                        Expanded(
                          child: Text(
                            "EGP ${model.deliveryCoast}",
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(context).textTheme.headlineMedium,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height / AppSize.s80,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          AppStrings.name.tr(),
                          style: Theme.of(context).textTheme.headlineLarge,
                        ),
                        Text(
                          " :",
                          style: Theme.of(context).textTheme.headlineLarge,
                        ),
                        SizedBox(
                          width:
                              MediaQuery.of(context).size.width / AppSize.s40,
                        ),
                        Expanded(
                          child: Text(
                            model.name.toTitleCase(),
                            style: Theme.of(context).textTheme.headlineMedium,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height / AppSize.s80,
                    ),
                    Row(
                      children: [
                        Text(
                          AppStrings.phone.tr(),
                          style: Theme.of(context).textTheme.headlineLarge,
                        ),
                        Text(
                          " :",
                          style: Theme.of(context).textTheme.headlineLarge,
                        ),
                        SizedBox(
                          width:
                              MediaQuery.of(context).size.width / AppSize.s40,
                        ),
                        Expanded(
                          child: Text(
                            model.phone,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(context).textTheme.headlineMedium,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height / AppSize.s80,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          AppStrings.address.tr(),
                          style: Theme.of(context).textTheme.headlineLarge,
                        ),
                        Text(
                          " :",
                          style: Theme.of(context).textTheme.headlineLarge,
                        ),
                        SizedBox(
                          width:
                              MediaQuery.of(context).size.width / AppSize.s40,
                        ),
                        Expanded(
                          child: Text(
                            model.address,
                            style: Theme.of(context).textTheme.headlineMedium,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      );
}
