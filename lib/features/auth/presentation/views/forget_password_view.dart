import 'package:chat/features/auth/presentation/views/reset_password_view.dart';
import 'package:chat/features/auth/presentation/views/widgets/app_logo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import '../../../../core/cache_helper/cache_helper.dart';
import '../../../../core/methods/navigation.dart';
import '../../../../core/methods/show_snack_bar.dart';
import '../../../../core/methods/translate.dart';
import '../../../../core/service_locator/service_locator.dart';
import '../../../../core/utils/app_constance.dart';
import '../../../../core/utils/app_dimensions.dart';
import '../../../../core/utils/app_styles.dart';
import '../../../../core/widgets/custom_button.dart';
import '../../../../core/widgets/custom_circular_progress_indicator.dart';
import '../../../../core/widgets/custom_text_form_field.dart';
import '../manager/auth_cubit/auth_cubit.dart';
import '../manager/auth_cubit/auth_states.dart';

class ForgetPasswordView extends StatelessWidget {
  const ForgetPasswordView({super.key});

  static var emailController = TextEditingController();
  static var formKey = GlobalKey<FormState>();

  Future<void> validate(BuildContext context) async {
    if(formKey.currentState!.validate()){
      await context.read<AuthCubit>().sendPasswordResetCode(emailController.text);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(25),
          child: Stack(
            children: [
              Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppLogo(),
                    SizedBox(
                      height: AppDimensions.height * .1,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${'please_enter_your'.tr} ${'email'.tr}',
                          style: AppStyles.style17,
                        ),
                        SizedBox(
                          height: AppDimensions.height * .05,
                        ),
                        CustomTextFormField(
                          pIcon: Icons.email_outlined,
                          title: 'email'.tr,
                          controller: emailController,
                        ),
                        SizedBox(
                          height: AppDimensions.height * .02,
                        ),
                        Text(
                          'we_will_send_you_a_code'.tr,
                          style:
                              AppStyles.style13.copyWith(
                                  color: CacheHelper.isDarkMode ? Colors.grey :Colors.black26
                              ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              BlocConsumer<AuthCubit, AuthStates>(
                listener: (context, state) async{
                  if (state is SendPasswordResetCodeSuccessfullyState) {
                    showSnackBar(
                      context: context,
                      label: 'check_your_email'.tr,
                      color: AppConstance.primaryColor,
                    );
                    navigateAndRemoveUntil(context: context, screen:
                    BlocProvider.value(
                        value: serviceLocator<AuthCubit>(),
                        child: ResetPasswordView(email: state.email,)
                    )
                    );
                  }
                  if(state is SendPasswordResetCodeErrorState){
                    showSnackBar(
                      context: context,
                      label: CacheHelper.isAr != false ? await translateEnglishToArabic(state.error) : state.error,
                      color: Colors.red,
                    );
                  }
                },
                builder: (context, state) {
                  if(state is SendPasswordResetCodeLoadingState){
                    return CustomCircularProgressIndicator();
                  }
                  return Positioned(
                    bottom: AppDimensions.height * .03,
                    right: 0,
                    left: 0,
                    child: CustomButton(
                      backgroundColor: AppConstance.primaryColor,
                      title: 'confirm'.tr,
                      onPressed: () async {
                        await validate(context);
                      },
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
