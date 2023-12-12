// ignore_for_file: must_be_immutable

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../controller/bloc.dart';
import '/app/resources/strings_manager.dart';
import 'package:mamlakty/presentation/auth/controller/states.dart';
import 'package:mamlakty/presentation/checkout/view/checkout_screen.dart';
import '/app/common/widget.dart';
import '/app/resources/assets_manager.dart';
import '/app/resources/color_manager.dart';
import '/app/resources/font_manager.dart';
import '/app/resources/language_manager.dart';
import '/app/resources/values_manager.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import '/app/services/shared_prefrences/cache_helper.dart';

class RegisterScreen extends StatelessWidget {
  RegisterScreen({super.key});
  var formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final addressController = TextEditingController();
  final noteController = TextEditingController();
  final phoneNumberController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: MediaQuery.of(context).size.width / AppSize.s10,
            vertical: MediaQuery.of(context).size.height / AppSize.s10,
          ),
          child: Center(
            child: BlocProvider(
              create: (context) => AuthBloc()..getArea(),
              child: BlocBuilder<AuthBloc, AuthStates>(
                builder: (context, satet) {
                  return Column(
                    children: [
                      Align(
                        alignment: AlignmentDirectional.topStart,
                        child: InkWell(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: const Icon(
                            Icons.arrow_back_ios,
                          ),
                        ),
                      ),
                      SizedBox(
                        height:
                            MediaQuery.of(context).size.height / AppSize.s50,
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal:
                              MediaQuery.of(context).size.width / AppSize.s20,
                          vertical:
                              MediaQuery.of(context).size.height / AppSize.s30,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(
                            AppSize.s10.w,
                          ),
                        ),
                        width: double.infinity,
                        child: Column(
                          children: [
                            Text(
                              AppStrings.createOrder.tr(),
                              style: Theme.of(context).textTheme.headlineLarge,
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height /
                                  AppSize.s30,
                            ),
                            SizedBox(
                              width: double.infinity,
                              child: Form(
                                key: formKey,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(AppStrings.name.tr(),
                                        style: Theme.of(context)
                                            .textTheme
                                            .displaySmall),
                                    SizedBox(
                                      height:
                                          MediaQuery.of(context).size.height /
                                              AppSize.s80,
                                    ),
                                    SharedWidget.defaultTextFormField(
                                      textInputType: TextInputType.name,
                                      context: context,
                                      controller: nameController,
                                      validator: (String? value) {
                                        if (value!.isEmpty) {
                                          return AppStrings.thisIsRequired.tr();
                                        }
                                        return null;
                                      },
                                    ),
                                    SizedBox(
                                      height:
                                          MediaQuery.of(context).size.height /
                                              AppSize.s30,
                                    ),
                                    Text(
                                      AppStrings.phoneNumber.tr(),
                                      style: Theme.of(context)
                                          .textTheme
                                          .displaySmall,
                                    ),
                                    SizedBox(
                                      height:
                                          MediaQuery.of(context).size.height /
                                              AppSize.s80,
                                    ),
                                    SharedWidget.defaultTextFormField(
                                      textInputType: TextInputType.phone,
                                      context: context,
                                      controller: phoneNumberController,
                                      validator: (String? value) {
                                        if (value!.isEmpty) {
                                          return AppStrings.thisIsRequired.tr();
                                        }
                                        return null;
                                      },
                                    ),
                                    SizedBox(
                                      height:
                                          MediaQuery.of(context).size.height /
                                              AppSize.s30,
                                    ),
                                    dropDownItem(context: context),
                                    SizedBox(
                                      height:
                                          MediaQuery.of(context).size.height /
                                              AppSize.s30,
                                    ),
                                    Text(AppStrings.address.tr(),
                                        style: Theme.of(context)
                                            .textTheme
                                            .displaySmall),
                                    SizedBox(
                                      height:
                                          MediaQuery.of(context).size.height /
                                              AppSize.s80,
                                    ),
                                    SharedWidget.defaultTextFormField(
                                      textInputType:
                                          TextInputType.streetAddress,
                                      context: context,
                                      controller: addressController,
                                      validator: (String? value) {
                                        if (value!.isEmpty) {
                                          return AppStrings.thisIsRequired.tr();
                                        }
                                        return null;
                                      },
                                    ),
                                    SizedBox(
                                      height:
                                          MediaQuery.of(context).size.height /
                                              AppSize.s30,
                                    ),
                                    Text(AppStrings.note.tr(),
                                        style: Theme.of(context)
                                            .textTheme
                                            .displaySmall),
                                    SizedBox(
                                      height:
                                          MediaQuery.of(context).size.height /
                                              AppSize.s80,
                                    ),
                                    SharedWidget.defaultTextFormField(
                                      textInputType: TextInputType.text,
                                      context: context,
                                      controller: noteController,
                                      maxLines: 5,
                                      validator: (String? value) {
                                        if (value!.isEmpty) {
                                          return AppStrings.thisIsRequired.tr();
                                        }
                                        return null;
                                      },
                                    ),
                                    SizedBox(
                                      height:
                                          MediaQuery.of(context).size.height /
                                              AppSize.s20,
                                    ),
                                    SharedWidget.defaultButton(
                                      width: double.infinity,
                                      context: context,
                                      onPressed: () {
                                        if (formKey.currentState!.validate()) {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (_) => CheckoutScreen(
                                                name: nameController.text,
                                                phone:
                                                    phoneNumberController.text,
                                                address: addressController.text,
                                                note: noteController.text,
                                                area: AuthBloc.get(context)
                                                    .selectedValue!,
                                                coast: AuthBloc.get(context)
                                                    .areaCoast(),
                                                deliveryAreaId:
                                                    AuthBloc.get(context)
                                                        .areaId(),
                                              ),
                                            ),
                                          );
                                        }
                                      },
                                      label: AppStrings.createOrder.tr(),
                                      background: ColorManager.primaryColor,
                                      labelColor: ColorManager.white,
                                    ),
                                    SizedBox(
                                      height:
                                          MediaQuery.of(context).size.height /
                                              AppSize.s80,
                                    ),
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget dropDownItem({
    required BuildContext context,
  }) {
    return DropdownButtonHideUnderline(
      child: DropdownButton2(
        iconOnClick: Image(
          image: const AssetImage(
            AssetsManager.arrowUp,
          ),
          width: AppSize.s16.w,
          height: AppSize.s16.h,
        ),
        isExpanded: true,
        hint: Row(
          children: [
            Expanded(
              child: Text(
                AppStrings.area.tr(),
                style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                      color: ColorManager.primaryColor,
                      fontSize: FontSizeManager.s18.sp,
                    ),
              ),
            ),
          ],
        ),
        items: AuthBloc.get(context)
            .areaList
            .map(
              (item) => DropdownMenuItem<String>(
                value: item,
                child: Text(
                  item,
                  style: Theme.of(context).textTheme.displaySmall!,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            )
            .toList(),
        value: AuthBloc.get(context).selectedValue,
        onChanged: (value) {
          AuthBloc.get(context).changeDropDownItem(value: value!);
        },
        icon: Image(
          image: const AssetImage(
            AssetsManager.arrowDown,
          ),
          width: AppSize.s16.w,
          height: AppSize.s16.h,
        ),
        buttonHeight: AppSize.s50.h,
        buttonWidth: double.infinity,
        buttonDecoration: BoxDecoration(
          borderRadius: BorderRadius.circular(
            AppSize.s10.w,
          ),
          color: ColorManager.white,
        ),
        buttonPadding: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width / AppSize.s22,
        ),
        itemHeight: AppSize.s42.h,
        dropdownMaxHeight: AppSize.s150.h,
        dropdownWidth: MediaQuery.of(context).size.width / AppSize.s1_7,
        scrollbarRadius: Radius.circular(
          AppSize.s10.w,
        ),
        dropdownDecoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(
              AppSize.s20.w,
            ),
            bottomRight: Radius.circular(
              AppSize.s20.w,
            ),
          ),
          color: ColorManager.white,
        ),
        scrollbarThickness: AppSize.s8.w,
        offset: CacheHelper.getData(key: SharedKey.Language) ==
                    LanguageType.ENGLISH.getValue() ||
                CacheHelper.getData(key: SharedKey.Language) == null
            ? Offset(AppSize.s20.w, 0)
            : Offset(-AppSize.s20.w, 0),
      ),
    );
  }
}
