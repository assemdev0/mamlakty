import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mamlakty/app/constant/enums_extentions.dart';
import '../../../app/resources/color_manager.dart';
import '../../../app/resources/strings_manager.dart';
import '../../../app/resources/values_manager.dart';
import '../../../model/category_model.dart';
import '../../product_in_category/view/product_in_category_screen.dart';
import '../controller/bloc.dart';
import '../controller/states.dart';

class CategoryScreen extends StatelessWidget {
  const CategoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CategoryBloc()..getCategories(),
      child: BlocBuilder<CategoryBloc, CategoryStates>(
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              title: Text(
                AppStrings.category.tr(),
                style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                      color: ColorManager.white,
                    ),
              ),
            ),
            body: Padding(
              padding: EdgeInsetsDirectional.symmetric(
                horizontal: MediaQuery.of(context).size.width / AppSize.s50,
                vertical: MediaQuery.of(context).size.height / AppSize.s40,
              ),
              child: CategoryBloc.get(context).categoryModel.data.isNotEmpty
                  ? ListView.separated(
                      itemBuilder: (context, index) => categoryItem(
                        context: context,
                        model:
                            CategoryBloc.get(context).categoryModel.data[index],
                      ),
                      separatorBuilder: (context, index) => SizedBox(
                        height:
                            MediaQuery.of(context).size.height / AppSize.s80,
                      ),
                      itemCount:
                          CategoryBloc.get(context).categoryModel.data.length,
                    )
                  : const Center(
                      child: CircularProgressIndicator(
                        color: ColorManager.primaryColor,
                      ),
                    ),
            ),
          );
        },
      ),
    );
  }

  Widget categoryItem({
    required BuildContext context,
    required CategoryDataModel model,
  }) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ProductInCategoryScreen(
                      id: model.id,
                      categoryName: model.name,
                    )));
      },
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: Container(
              height: AppSize.s100.h,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(model.image),
                  fit: BoxFit.fill,
                ),
                color: ColorManager.primaryColor,
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
            child: Text(
              model.name.toTitleCase(),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context)
                  .textTheme
                  .headlineMedium!
                  .copyWith(color: ColorManager.yellow),
            ),
          ),
        ],
      ),
    );
  }
}
