import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mamlakty/app/constant/enums_extentions.dart';
import 'package:mamlakty/presentation/product_in_category/controller/states.dart';

import '../../../app/common/widget.dart';
import '../../../app/resources/color_manager.dart';
import '../../../app/resources/strings_manager.dart';
import '../../../app/resources/values_manager.dart';
import '../controller/bloc.dart';

class SearchScreen extends StatelessWidget {
  SearchScreen({
    super.key,
    required this.categoryName,
    required this.id,
  });
  final int id;
  final searchController = TextEditingController();
  final String categoryName;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProductInCategoryBloc(),
      child: BlocBuilder<ProductInCategoryBloc, ProductInCategoryStates>(
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              title: Text(
                categoryName.toTitleCase(),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                      color: ColorManager.white,
                    ),
              ),
            ),
            body: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height / AppSize.s40,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal:
                          MediaQuery.of(context).size.width / AppSize.s50,
                    ),
                    child: SharedWidget.defaultTextFormField(
                      context: context,
                      controller: searchController,
                      hint: AppStrings.search.tr(),
                      onFieldSubmitted: (String? value) {
                        if (ProductInCategoryBloc.get(context).sliderValue ==
                            0.0) {
                          ProductInCategoryBloc.get(context)
                              .seachInCategoryWithName(
                            categoryId: id,
                            name: value!,
                          );
                        }
                        ProductInCategoryBloc.get(context).seachInCategory(
                          categoryId: id,
                          name: value!,
                          maxPrice:
                              ProductInCategoryBloc.get(context).sliderValue,
                        );
                      },
                      textInputType: TextInputType.text,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal:
                          MediaQuery.of(context).size.width / AppSize.s50,
                      vertical:
                          MediaQuery.of(context).size.height / AppSize.s40,
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          flex: 2,
                          child: Slider(
                            value:
                                ProductInCategoryBloc.get(context).sliderValue,
                            onChanged: (double value) {
                              ProductInCategoryBloc.get(context)
                                  .changeSliderValue(value: value);
                            },
                            min: AppSize.s0,
                            max: 4000,
                          ),
                        ),
                        Text(
                            "${ProductInCategoryBloc.get(context).sliderValue.round()} ${AppStrings.max.tr()}"),
                        SizedBox(
                          width:
                              MediaQuery.of(context).size.width / AppSize.s40,
                        ),
                        Expanded(
                          child: SharedWidget.defaultButton(
                            label: AppStrings.search.tr(),
                            context: context,
                            width: double.infinity,
                            onPressed: () {
                              ProductInCategoryBloc.get(context)
                                  .seachInCategoryWithPrice(
                                categoryId: id,
                                maxPrice: ProductInCategoryBloc.get(context)
                                    .sliderValue,
                              );
                            },
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height / AppSize.s40,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal:
                          MediaQuery.of(context).size.width / AppSize.s50,
                    ),
                    child: ProductInCategoryBloc.get(context)
                            .serchProduct
                            .data
                            .isNotEmpty
                        ? GridView.builder(
                            shrinkWrap: true,
                            itemCount: ProductInCategoryBloc.get(context)
                                .serchProduct
                                .data
                                .length,
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) {
                              return SharedWidget.productItem(
                                context: context,
                                model: ProductInCategoryBloc.get(context)
                                    .serchProduct
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
                  SizedBox(
                    height: MediaQuery.of(context).size.height / AppSize.s50,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
