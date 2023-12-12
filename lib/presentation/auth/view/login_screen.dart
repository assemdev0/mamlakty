// ignore_for_file: must_be_immutable

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../app/common/widget.dart';
import '../../../app/resources/color_manager.dart';
import '../../../app/resources/strings_manager.dart';
import '../../../app/resources/values_manager.dart';
import '../../../app/services/shared_prefrences/cache_helper.dart';
import '../controller/bloc.dart';
import '../controller/states.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});
  final emailController = TextEditingController();
  var formKey = GlobalKey<FormState>();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: MediaQuery.of(context).size.width / AppSize.s10,
            vertical: MediaQuery.of(context).size.height / AppSize.s8,
          ),
          child: Center(
            child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).size.width / AppSize.s20,
                vertical: MediaQuery.of(context).size.height / AppSize.s30,
              ),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(AppSize.s10.w),
                  color: Colors.white),
              width: double.infinity,
              child: Column(
                children: [
                  InkWell(
                    onTap: () {
                      SharedWidget.changeLanguage(context);
                    },
                    child: Align(
                      alignment: Alignment.topRight,
                      child: Container(
                        color: ColorManager.yellow,
                        child: Padding(
                          padding: EdgeInsets.all(
                            MediaQuery.of(context).size.width / AppSize.s80,
                          ),
                          child: Text(
                            AppStrings.en.tr(),
                            style: Theme.of(context).textTheme.displayMedium,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height / AppSize.s30,
                  ),
                  Text(
                    AppStrings.login.tr(),
                    style: Theme.of(context).textTheme.headlineLarge,
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height / AppSize.s30,
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: Form(
                      key: formKey,
                      child: BlocProvider(
                        create: (context) => AuthBloc(),
                        child: BlocConsumer<AuthBloc, AuthStates>(
                          listener: (context, state) {
                            if (state is LoginErrorState) {
                              SharedWidget.toast(
                                backgroundColor: ColorManager.error,
                                message:
                                    AppStrings.emailOrPasswordNotCorrect.tr(),
                              );
                            } else if (state is LoginSuccessState) {
                              CacheHelper.setData(
                                key: SharedKey.token,
                                value: AuthBloc.get(context).userModel.token,
                              );
                              CacheHelper.setData(
                                  key: SharedKey.id,
                                  value:
                                      AuthBloc.get(context).userModel.data.id);

                              Navigator.pop(context);
                            }
                          },
                          builder: (context, state) {
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(AppStrings.userName.tr(),
                                    style: Theme.of(context)
                                        .textTheme
                                        .displaySmall),
                                SizedBox(
                                  height: MediaQuery.of(context).size.height /
                                      AppSize.s80,
                                ),
                                SharedWidget.defaultTextFormField(
                                  textInputType: TextInputType.emailAddress,
                                  context: context,
                                  validator: (String? value) {
                                    if (value!.isEmpty) {
                                      return AppStrings.thisIsRequired.tr();
                                    }
                                    if (value.contains("@") == false) {
                                      return AppStrings.emailNotationValidation
                                          .tr();
                                    }
                                    return null;
                                  },
                                  controller: emailController,
                                ),
                                SizedBox(
                                  height: MediaQuery.of(context).size.height /
                                      AppSize.s30,
                                ),
                                Text(
                                  AppStrings.password.tr(),
                                  style:
                                      Theme.of(context).textTheme.displaySmall,
                                ),
                                SizedBox(
                                  height: MediaQuery.of(context).size.height /
                                      AppSize.s80,
                                ),
                                SharedWidget.defaultTextFormField(
                                  textInputType: TextInputType.visiblePassword,
                                  context: context,
                                  controller: passwordController,
                                  obscure:
                                      AuthBloc.get(context).isShownPassword,
                                  suffixIcon: IconButton(
                                    onPressed: () {
                                      AuthBloc.get(context)
                                          .changeVisibilityPassword();
                                    },
                                    icon: AuthBloc.get(context).suffixPassword,
                                  ),
                                  validator: (String? value) {
                                    if (value!.isEmpty) {
                                      return AppStrings.thisIsRequired.tr();
                                    } else if (value.length < 8) {
                                      return AppStrings
                                          .itMustBeAtLeast8Characters
                                          .tr();
                                    }
                                    return null;
                                  },
                                ),
                                SizedBox(
                                  height: MediaQuery.of(context).size.height /
                                      AppSize.s30,
                                ),
                                state is! LoginLoadingState
                                    ? SharedWidget.defaultButton(
                                        context: context,
                                        width: double.infinity,
                                        onPressed: () {
                                          if (formKey.currentState!
                                              .validate()) {
                                            AuthBloc.get(context).loginUser(
                                              email: emailController.text,
                                              password: passwordController.text,
                                            );
                                          }
                                        },
                                        label: AppStrings.login.tr(),
                                        background: ColorManager.primaryColor,
                                        labelColor: ColorManager.white,
                                      )
                                    : const Center(
                                        child: CircularProgressIndicator(
                                          color: ColorManager.primaryColor,
                                        ),
                                      ),
                                SizedBox(
                                  height: MediaQuery.of(context).size.height /
                                      AppSize.s80,
                                ),
                              ],
                            );
                          },
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
