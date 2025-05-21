import 'package:chat/core/utils/app_constance.dart';
import 'package:chat/core/utils/app_styles.dart';
import 'package:chat/core/widgets/custom_button.dart';
import 'package:chat/core/widgets/custom_circular_progress_indicator.dart';
import 'package:chat/core/widgets/empty_list_widget.dart';
import 'package:chat/features/add_friend/presentation/manager/add_friend_cubit/add_friend_cubit.dart';
import 'package:chat/features/add_friend/presentation/manager/add_friend_cubit/add_friend_states.dart';
import 'package:chat/features/add_friend/presentation/views/widgets/search_result_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

import '../../../../core/widgets/custom_app_bar.dart';
import '../../../../core/widgets/custom_text_form_field.dart';

class AddFriendView extends StatelessWidget {
  const AddFriendView({super.key});

  static var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var cubit = context.read<AddFriendCubit>();
    cubit.handleInitial();
    return Scaffold(
      appBar: CustomAppBar(title: 'add_friend'.tr),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomTextFormField(
                  title: 'email'.tr,
                  controller: cubit.emailController,
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  'please_enter_user_email'.tr,
                  style: AppStyles.style13Grey,
                ),
                SizedBox(
                  height: 30,
                ),
                BlocBuilder<AddFriendCubit, AddFriendStates>(
                  builder: (context, state) {
                    if (state is FindUserLoadingState) {
                      return CustomCircularProgressIndicator();
                    }
                    return CustomButton(
                      backgroundColor: AppConstance.primaryColor,
                      title: 'confirm'.tr,
                      onPressed: () async {
                        if (formKey.currentState!.validate()) {
                          await cubit.findUser(cubit.emailController.text);
                        }
                      },
                    );
                  },
                ),
                SizedBox(
                  height: 30,
                ),
                  BlocBuilder<AddFriendCubit, AddFriendStates>(
                    builder: (context, state) {
                      if(state is AddFriendErrorState){
                        return EmptyListWidget();
                      }
                      if(cubit.user != null) {
                        return SearchResultWidget(user: cubit.user!,);
                      }
                      return Container();
                    },
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
