// ignore_for_file: library_prefixes

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mamlakty/app/constant/enums_extentions.dart';
import '../../../../app/resources/color_manager.dart';
import '../../../../app/resources/values_manager.dart';
import '../../../app/resources/strings_manager.dart';
import '../../../model/orders_model.dart';
import '../../product_details/view/product_details_screen.dart';

class OrderDetailsScreen extends StatelessWidget {
  const OrderDetailsScreen({
    super.key,
    required this.ordersDataModel,
  });
  final OrdersDataModel ordersDataModel;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppStrings.orderDetails.tr(),
          style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                color: ColorManager.white,
              ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width / AppSize.s30,
          vertical: MediaQuery.of(context).size.height / AppSize.s30,
        ),
        child: Column(
          children: [
            Expanded(
              child: ListView.separated(
                physics: const BouncingScrollPhysics(),
                itemBuilder: (context, index) => orderDetailsItem(
                  model: ordersDataModel.items[index],
                  context: context,
                ),
                separatorBuilder: (context, index) => Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: MediaQuery.of(context).size.height / AppSize.s50,
                  ),
                  child: Container(
                    color: ColorManager.primaryColor,
                    width: double.infinity,
                    height: AppSize.s1,
                  ),
                ),
                itemCount: ordersDataModel.items.length,
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget orderDetailsItem(
          {required BuildContext context, required OrdersItemsModel model}) =>
      InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ProductDetailsScreen(
                id: model.product.id,
                name: model.product.name,
                categoryId: model.product.category.id,
              ),
            ),
          );
        },
        child: Row(
          children: [
            Expanded(
              flex: 2,
              child: Container(
                clipBehavior: Clip.antiAliasWithSaveLayer,
                decoration: BoxDecoration(
                  color: ColorManager.primaryColor,
                  borderRadius: BorderRadius.circular(
                    AppSize.s8.w,
                  ),
                ),
                height: AppSize.s100.h,
                child: model.product.images.isEmpty
                    ? Container(
                        color: ColorManager.grey,
                      )
                    : Image(
                        image: NetworkImage(
                          model.product.images[0].image,
                        ),
                        fit: BoxFit.fill,
                      ),
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width / AppSize.s60,
            ),
            Expanded(
              flex: 3,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    model.product.name.toTitleCase(),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height / AppSize.s80,
                  ),
                  Text(
                    model.product.category.name.toTitleCase(),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.displaySmall!,
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height / AppSize.s80,
                  ),
                  Text(
                    "EGP  ${model.product.price}",
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height / AppSize.s50,
                  ),
                ],
              ),
            ),
          ],
        ),
      );
}
