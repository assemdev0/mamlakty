import 'package:conditional_builder_rec/conditional_builder_rec.dart';
import 'package:easy_localization/easy_localization.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../app/common/widget.dart';
import '../../../app/resources/color_manager.dart';
import '../../../app/resources/routes_manager.dart';
import '../../../app/resources/strings_manager.dart';
import '../../../app/resources/values_manager.dart';
import '../../../app/services/shared_prefrences/cache_helper.dart';
import '../controller/bloc.dart';
import '../controller/states.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({super.key});
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppStrings.profile.tr(),
          style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                color: ColorManager.white,
              ),
        ),
      ),
      body: BlocProvider(
        create: (context) => ProfileBLoc()..getProfile(),
        child: BlocConsumer<ProfileBLoc, ProfileStates>(
          listener: (context, state) {
            if (state is EditProfileErrorState) {
              SharedWidget.toast(
                message: AppStrings.anErrorOccurredTryAgain.tr(),
                backgroundColor: ColorManager.error,
              );
              Navigator.pop(context);
            }
          },
          builder: (context, state) {
            return Padding(
              padding: EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).size.width / AppSize.s20,
              ),
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: ConditionalBuilderRec(
                  condition: state is ProfileSuccessState ||
                      state is EditProfileSuccessState,
                  builder: (context) {
                    nameController.text =
                        ProfileBLoc.get(context).userDataModel.name;
                    emailController.text =
                        ProfileBLoc.get(context).userDataModel.email;

                    phoneController.text =
                        ProfileBLoc.get(context).userDataModel.phone;
                    return Form(
                      key: formKey,
                      child: Column(
                        children: [
                          SizedBox(
                            height: MediaQuery.of(context).size.height /
                                AppSize.s30,
                          ),
                          SharedWidget.defaultTextFormField(
                              context: context,
                              textInputType: TextInputType.name,
                              controller: nameController,
                              validator: (String? value) {
                                if (value!.isEmpty) {
                                  return AppStrings.thisIsRequired.tr();
                                }
                                return null;
                              },
                              suffixIcon: const Icon(Icons.edit)),
                          SizedBox(
                            height: MediaQuery.of(context).size.height /
                                AppSize.s20,
                          ),
                          SharedWidget.defaultTextFormField(
                              context: context,
                              textInputType: TextInputType.emailAddress,
                              controller: emailController,
                              validator: (String? value) {
                                if (value!.isEmpty) {
                                  return AppStrings.thisIsRequired.tr();
                                }
                                return null;
                              },
                              suffixIcon: const Icon(Icons.edit)),
                          SizedBox(
                            height: MediaQuery.of(context).size.height /
                                AppSize.s20,
                          ),
                          SharedWidget.defaultTextFormField(
                              context: context,
                              textInputType: TextInputType.phone,
                              controller: phoneController,
                              validator: (String? value) {
                                if (value!.isEmpty) {
                                  return AppStrings.thisIsRequired.tr();
                                }
                                return null;
                              },
                              suffixIcon: const Icon(Icons.edit)),
                          SizedBox(
                            height: MediaQuery.of(context).size.height /
                                AppSize.s20,
                          ),
                          SharedWidget.defaultTextFormField(
                              context: context,
                              textInputType: TextInputType.visiblePassword,
                              obscure: true,
                              hint: AppStrings.password.tr(),
                              controller: passwordController,
                              validator: (String? value) {
                                if (value!.isEmpty) {
                                  return AppStrings.thisIsRequired.tr();
                                }
                                return null;
                              },
                              suffixIcon: const Icon(Icons.edit)),
                          SizedBox(
                            height: MediaQuery.of(context).size.height /
                                AppSize.s20,
                          ),
                          profileItem(
                            context: context,
                            label: AppStrings.orderHistory.tr(),
                            icon: const Icon(Icons.arrow_right_outlined),
                            onPressed: () {
                              Navigator.pushNamed(
                                context,
                                Routes.orderRoute,
                              );
                            },
                          ),
                          profileItem(
                            context: context,
                            label: AppStrings.language.tr(),
                            icon: const Icon(Icons.change_circle),
                            onPressed: () {
                              SharedWidget.changeLanguage(context);
                            },
                          ),
                          profileItem(
                            context: context,
                            label: AppStrings.logout.tr(),
                            icon: const Icon(Icons.arrow_right_outlined),
                            onPressed: () {
                              CacheHelper.removeData(key: SharedKey.id);
                              CacheHelper.removeData(key: SharedKey.token);
                              Navigator.pushReplacementNamed(
                                context,
                                Routes.homeRoute,
                              );
                            },
                          ),
                          SharedWidget.defaultButton(
                              label: AppStrings.editProfile.tr(),
                              context: context,
                              width: double.infinity,
                              onPressed: () {
                                if (formKey.currentState!.validate()) {
                                  ProfileBLoc.get(context).editUser(
                                    name: nameController.text,
                                    email: emailController.text,
                                    phone: phoneController.text,
                                    password: passwordController.text,
                                  );
                                }
                              }),
                          SizedBox(
                            height: MediaQuery.of(context).size.height /
                                AppSize.s20,
                          ),
                        ],
                      ),
                    );
                  },
                  fallback: (context) {
                    return Padding(
                      padding: EdgeInsets.symmetric(
                          vertical:
                              MediaQuery.of(context).size.height / AppSize.s3),
                      child: const Center(
                        child: CircularProgressIndicator(
                            color: ColorManager.primaryColor),
                      ),
                    );
                  },
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget profileItem({
    required BuildContext context,
    required String label,
    required Icon icon,
    required Function() onPressed,
  }) =>
      InkWell(
        onTap: onPressed,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  label,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                        color: ColorManager.yellow,
                      ),
                ),
                icon,
              ],
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height / AppSize.s80,
            ),
            Container(
              color: ColorManager.primaryColor,
              width: double.infinity,
              height: AppSize.s1,
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height / AppSize.s20,
            ),
          ],
        ),
      );
}
