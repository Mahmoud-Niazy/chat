import '../../../../core/methods/navigation.dart';
import '../../../../core/utils/app_dimensions.dart';
import '../../../../core/utils/app_styles.dart';
import '../../../../core/widgets/custom_circular_progress_indicator.dart';
import '../../../../core/widgets/custom_text_form_field.dart';
import 'package:chat/features/auth/presentation/manager/auth_cubit/auth_cubit.dart';
import 'package:chat/features/auth/presentation/manager/auth_cubit/auth_states.dart';
import 'package:chat/features/auth/presentation/views/login_view.dart';
import 'package:chat/features/auth/presentation/views/widgets/app_logo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import '../../../../core/cache_helper/cache_helper.dart';
import '../../../../core/methods/show_snack_bar.dart';
import '../../../../core/methods/translate.dart';
import '../../../../core/utils/app_constance.dart';
import '../../../../core/widgets/custom_button.dart';

class ResetPasswordView extends StatelessWidget {
  final String email;

  const ResetPasswordView({
    super.key,
    required this.email,
  });

  static var newPasswordController = TextEditingController();
  static var repeatPasswordController = TextEditingController();
  static var codeController = TextEditingController();

  static var formKey = GlobalKey<FormState>();

  Future<void> resetPassword(BuildContext context) async {
    if(formKey.currentState!.validate()){
      await context.read<AuthCubit>().resetPassword(
        code: num.parse(codeController.text),
        newPassword: newPasswordController.text,
        email: email,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: SafeArea(
          child: Stack(
            children: [
              Form(
                key: formKey,
                child: Column(
                  children: [
                    AppLogo(),
                    SizedBox(
                      height: AppDimensions.height * .1,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'please_enter_code_you_recieved_in_your_email'.tr,
                          style: AppStyles.style20,
                        ),
                        SizedBox(
                          height: AppDimensions.height * .05,
                        ),
                        CustomTextFormField(
                          title: 'code'.tr,
                          pIcon: Icons.textsms_outlined,
                          controller: codeController,
                        ),
                        SizedBox(
                          height: AppDimensions.height * .02,
                        ),
                        CustomTextFormField(
                          title: 'new_password'.tr,
                          isPassword: true,
                          isSuffixIconShown: true,

                          controller: newPasswordController,
                        ),
                        SizedBox(
                          height: AppDimensions.height * .02,
                        ),
                        CustomTextFormField(
                          title: 'repeat_password'.tr,
                          isPassword: true,
                          isSuffixIconShown: true,
                          controller: repeatPasswordController,
                        ),
                        SizedBox(
                          height: AppDimensions.height * .02,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Positioned(
                bottom: AppDimensions.height * .03,
                right: 0,
                left: 0,
                child: BlocConsumer<AuthCubit, AuthStates>(
                  listener: (context, state) async{
                    if (state is ResetPasswordSuccessfullyState) {
                      showSnackBar(
                        context: context,
                        label: 'success'.tr,
                        color: AppConstance.primaryColor,
                      );
                      navigateAndRemoveUntil(context: context, screen: LoginView());
                    }
                    if (state is ResetPasswordErrorState) {
                      showSnackBar(
                        context: context,
                        label: CacheHelper.isAr != false ? await translateEnglishToArabic(state.error) : state.error,
                        color: Colors.red,
                      );
                    }
                  },
                  builder: (context, state) {
                    if (state is ResetPasswordLoadingState) {
                      return CustomCircularProgressIndicator();
                    }
                    return CustomButton(
                      backgroundColor: AppConstance.primaryColor,
                      title: 'confirm'.tr,
                      onPressed: () async {
                        await resetPassword(context);
                      },
                    );
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
