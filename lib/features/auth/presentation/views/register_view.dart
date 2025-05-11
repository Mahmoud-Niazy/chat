import '../../../../core/methods/show_snack_bar.dart';
import '../../../../core/utils/app_constance.dart';
import '../../../../core/utils/app_styles.dart';
import '../../../../core/widgets/custom_button.dart';
import '../../../../core/widgets/custom_circular_progress_indicator.dart';
import '../../../../core/widgets/custom_text_form_field.dart';
import 'package:chat/features/auth/presentation/manager/auth_cubit/auth_cubit.dart';
import 'package:chat/features/auth/presentation/manager/auth_cubit/auth_states.dart';
import 'package:chat/features/auth/presentation/views/widgets/app_logo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import '../../../../core/cache_helper/cache_helper.dart';
// import '../../../../core/methods/navigation.dart';
import '../../../../core/methods/translate.dart';
// import '../../../../core/scocket_io_services/socket_services.dart';
import '../../../../core/utils/app_dimensions.dart';
// import '../../../layout/presentation/view/layout_view.dart';

class RegisterView extends StatelessWidget {
  static var emailController = TextEditingController();
  static var passwordController = TextEditingController();
  static var phoneController = TextEditingController();
  static var nameController = TextEditingController();
  static var formKey = GlobalKey<FormState>();

  const RegisterView({super.key});

  void clearControllers(){
    emailController.text = '';
    passwordController.text = '';
    phoneController.text = '';
    nameController.text = '';
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvokedWithResult: (p,n){
        clearControllers();
      },
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Center(
              child: SingleChildScrollView(
                child: Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AppLogo(),
                      SizedBox(
                        height: AppDimensions.height * .06,
                      ),
                       Text(
                        'register_now_to_explore_our_courses'.tr,
                        style: AppStyles.style20,
                      ),
                      SizedBox(
                        height: AppDimensions.height * .03,
                      ),
                      CustomTextFormField(
                        title: 'name'.tr,
                        pIcon: Icons.person,
                        controller: nameController,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      CustomTextFormField(
                        title: 'email'.tr,
                        keyboardType: TextInputType.emailAddress,
                        pIcon: Icons.email_outlined,
                        controller: emailController,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      CustomTextFormField(
                        title: 'password'.tr,
                        pIcon: Icons.lock_open,
                        isSuffixIconShown: true,
                        isPassword: true,
                        controller: passwordController,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      CustomTextFormField(
                        title: 'phone'.tr,
                        pIcon: Icons.phone_android_outlined,
                        controller: phoneController,
                        keyboardType: TextInputType.number,
                      ),
                      SizedBox(
                        height: AppDimensions.height * .04,
                      ),
                      BlocConsumer<AuthCubit, AuthStates>(
                        listener: (context, state) async {
                          if (state is SignUpSuccessfullyState) {
                            showSnackBar(
                              context: context,
                              label: 'success'.tr,
                              color: AppConstance.primaryColor,
                            );
                            /// TODO Navigation after authentication & init socket
                            // navigateAndRemoveUntil(
                            //   context: context,
                            //   screen: const LayoutView(),
                            // );
                            // SocketService().init();
                          }
                          if (state is SignUpErrorState) {
                            showSnackBar(
                              context: context,
                              label: CacheHelper.isAr != false ? await translateEnglishToArabic(state.error) : state.error,
                              color: Colors.red,
                            );
                          }
                        },
                        builder: (context, state) {
                          var cubit = AuthCubit.get(context);
                          if (state is SignUpLoadingState) {
                            return const CustomCircularProgressIndicator();
                          }
                          return CustomButton(
                            backgroundColor: AppConstance.primaryColor,
                            title: 'sign_up'.tr,
                            onPressed: () {
                              if (formKey.currentState!.validate()) {
                                cubit.signUp(
                                  email: emailController.text,
                                  password: passwordController.text,
                                  phone: phoneController.text,
                                  name: nameController.text,
                                );
                              }
                            },
                          );
                        },
                      ),
                      SizedBox(
                        height: AppDimensions.height * .01,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
