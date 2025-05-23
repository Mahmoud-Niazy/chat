import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import '../../../../core/cache_helper/cache_helper.dart';
import '../../../../core/methods/navigation.dart';
import '../../../../core/methods/show_snack_bar.dart';
import '../../../../core/methods/translate.dart';
import '../../../../core/utils/app_assets.dart';
import '../../../../core/utils/app_constance.dart';
import '../../../../core/utils/app_styles.dart';
import '../../../../core/widgets/custom_button.dart';
import '../../../../core/widgets/custom_circular_progress_indicator.dart';
import '../../../../core/widgets/custom_underlined_text_form_field.dart';
import '../../../layout/presentation/view/layout_view.dart';
import '../managers/edit_profile_cubit/edit_profile_cubit.dart';
import '../managers/edit_profile_cubit/edit_profile_states.dart';


class EditProfileView extends StatefulWidget {
  const EditProfileView({super.key});

  static late EditProfileCubit _cubit ;
  static var formKey = GlobalKey<FormState>();

  @override
  State<EditProfileView> createState() => _EditProfileViewState();

}

class _EditProfileViewState extends State<EditProfileView> {
  Future<void> validateAndUpdateData(BuildContext context) async{
    if(EditProfileView.formKey.currentState!.validate()) {
      await updateData();
    }
  }

  Future<void> updateData()async{
    await EditProfileView._cubit.updateUserData();
  }

  @override
  void dispose() {
    super.dispose();
    EditProfileView._cubit.currentPasswordController.text = '';
    EditProfileView._cubit.newPasswordController.text = '';
  }

  @override
  Widget build(BuildContext context) {

    EditProfileView._cubit = context.read<EditProfileCubit>();
    return Scaffold(
      appBar:  AppBar(
        title: Text(
          'edit_your_profile'.tr,
        ),
      ),
      body: BlocConsumer<EditProfileCubit, EditProfileStates>(
        listener: (context, state) async{
          if(state is UpdateUserDataSuccessfullyState){
            showSnackBar(
                context: context,
                label: "success".tr,
                color: AppConstance.primaryColor,
            );
            /// ToDo get user data && bottom navigation bar
            // await context.read<HomeCubit>().getUserData();
            // BottomNavigationBarCubit.get(context).currentIndex = 0;
            navigateAndRemoveUntil(context: context, screen: const LayoutView());
          }
          if (state is EditProfileErrorState) {
            showSnackBar(
                context: context,
                label: CacheHelper.isAr != false ? await translateEnglishToArabic(state.error) : state.error,
                color: AppConstance.warningColor);
          }
          if(state is NoImageSelectedState){
            showSnackBar(
              context: context,
              label: 'no_image_selected'.tr,
              color: AppConstance.warningColor,
            );
          }
          if(state is ImageSelectedSuccessfullyState){
            showSnackBar(
              context: context,
              label: 'image_selected_success'.tr,
              color: AppConstance.primaryColor,
            );
          }
        },
        builder: (context, state) {
          if (state is GetUserDataLoadingState) {
            return const CustomCircularProgressIndicator();
          }
          return Padding(
            padding: const EdgeInsets.all(20),
            child: SingleChildScrollView(
              child: Form(
                key: EditProfileView.formKey,
                child: Column(
                  children: [
                    SizedBox(
                      height:  80 ,
                      width:   80 ,
                      child: Stack(
                        alignment: Alignment.bottomRight,
                        children: [
                          EditProfileView._cubit.userImage != null ?
                          Container(
                            height:  80 ,
                            width:   80 ,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                // borderRadius: BorderRadius.circular(20),
                                image: DecorationImage(
                                    image: FileImage(File(EditProfileView._cubit.userImage!.path)),
                                    fit: BoxFit.cover)),
                          )
                          :
                          EditProfileView._cubit.userImageUrl.isNotEmpty ?
                          Container(
                            height:  80 ,
                            width:   80 ,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                // borderRadius: BorderRadius.circular(20),
                                image: DecorationImage(
                                    image: NetworkImage(EditProfileView._cubit.userImageUrl),
                                    fit: BoxFit.cover)),
                          )
                              :
                          Container(
                            height: MediaQuery.of(context).size.height * .2,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(image: AssetImage(AppAssets.userImage,
                              ),

                              )
                            ),
                          ),
                          InkWell(
                            onTap: (){
                              EditProfileView._cubit.pickImage();
                            },
                            child: Container(
                              height: 25,
                              width: 25,
                              decoration: BoxDecoration(
                                color: AppConstance.primaryColor,
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(
                                Icons.edit,
                                color: Colors.white,
                                size: 15,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    CustomUnderLineTextFieldWith(
                      type: TextInputType.emailAddress,
                      label: 'email'.tr,
                      controller: EditProfileView._cubit.emailController,
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    CustomUnderLineTextFieldWith(
                      type: TextInputType.emailAddress,
                      label: 'phone'.tr,
                      controller: EditProfileView._cubit.phoneController,
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    CustomUnderLineTextFieldWith(
                      type: TextInputType.emailAddress,
                      label: 'name'.tr,
                      controller: EditProfileView._cubit.nameController,
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    CustomUnderLineTextFieldWith(
                      type: TextInputType.emailAddress,
                      label: 'password'.tr,
                      isSuffixIconShown: true,
                      isPassword: true,
                      controller: EditProfileView._cubit.currentPasswordController,
                    ),
                    const SizedBox(
                      height: 15,
                    ),

                    CustomUnderLineTextFieldWith(
                      type: TextInputType.emailAddress,
                      label: 'new_password'.tr,
                      isSuffixIconShown: true,
                      isPassword: true,
                      controller: EditProfileView._cubit.newPasswordController,
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Text(
                      'password_note'.tr,
                      style: AppStyles.style13Grey,
                      textAlign: TextAlign.start,
                    ),

                    const SizedBox(
                      height: 30,
                    ),
                    state is UpdateUserDataLoadingState
                        ? const CustomCircularProgressIndicator()
                        : CustomButton(
                            title: 'confirm'.tr,
                            onPressed: () async {
                             validateAndUpdateData(context);
                            },
                      backgroundColor: AppConstance.primaryColor,
                          ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
