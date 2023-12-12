import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mamlakty/app/constant/enums_extentions.dart';
import 'package:mamlakty/presentation/product_in_category/view/search_screen.dart';
import '../../../app/common/widget.dart';
import '../../../app/resources/color_manager.dart';
import '../../../app/resources/strings_manager.dart';
import '../../../app/resources/values_manager.dart';
import '../controller/bloc.dart';
import '../controller/states.dart';

class ProductInCategoryScreen extends StatelessWidget {
  ProductInCategoryScreen({
    super.key,
    required this.id,
    required this.categoryName,
  });
  final int id;
  final searchController = TextEditingController();
  final String categoryName;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProductInCategoryBloc()
        ..getFirstLoadProduct(
          id: id,
        ),
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
              controller: ProductInCategoryBloc.get(context).controller,
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
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SearchScreen(
                              categoryName: categoryName,
                              id: id,
                            ),
                          ),
                        );
                      },
                      textInputType: TextInputType.none,
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
                            .productList
                            .isNotEmpty
                        ? GridView.builder(
                            shrinkWrap: true,
                            itemCount: ProductInCategoryBloc.get(context)
                                .productList
                                .length,
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) {
                              return SharedWidget.productItem(
                                context: context,
                                model: ProductInCategoryBloc.get(context)
                                    .productList[index],
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
                  if (ProductInCategoryBloc.get(context).isMoreLoading)
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
                  if (ProductInCategoryBloc.get(context).hasPages == false)
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
          );
        },
      ),
    );
  }
}
