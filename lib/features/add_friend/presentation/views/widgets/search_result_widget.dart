import 'package:chat/core/utils/app_assets.dart';
import 'package:chat/core/utils/app_dimensions.dart';
import 'package:chat/core/utils/app_styles.dart';
import 'package:chat/core/widgets/custom_circular_progress_indicator.dart';
import 'package:chat/features/add_friend/data/models/search_result_model/search_result_model.dart';
import 'package:chat/features/add_friend/presentation/manager/add_friend_cubit/add_friend_cubit.dart';
import 'package:chat/features/add_friend/presentation/manager/add_friend_cubit/add_friend_states.dart';
import 'package:chat/features/add_friend/presentation/views/widgets/action_button_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import '../../../../../core/utils/app_constance.dart';

class SearchResultWidget extends StatelessWidget {
  final SearchResultModel user;

  const SearchResultWidget({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    var cubit = context.read<AddFriendCubit>();
    return Container(
      margin: const EdgeInsets.only(top: 24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withValues(alpha: .6),
            spreadRadius: 1,
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppConstance.primaryColor.withValues(alpha: 0.1),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(16),
                topRight: Radius.circular(16),
              ),
            ),
            child: Row(
              children: [
                Container(
                  width: AppDimensions.width * .2,
                  height: AppDimensions.height * .1,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: AppConstance.primaryColor,
                      width: 2,
                    ),
                    image: DecorationImage(
                      image: (user.userProfileImage != null &&
                          user.userProfileImage != '') ?
                      NetworkImage(user.userProfileImage!)
                          :
                      AssetImage(AppAssets.userImage),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(user.name ?? '', style: AppStyles.style13),
                      const SizedBox(height: 4),
                      Text(user.email ?? '', style: AppStyles.style11Grey),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                BlocBuilder<AddFriendCubit, AddFriendStates>(
                  builder: (context, state) {
                    if(state is SendFriendRequestLoadingState){
                      return CustomCircularProgressIndicator();
                    }
                    return ActionButtonWidget(
                     user.isFriend == true ? Icons.person_remove_alt_1_outlined: Icons.person_add_outlined,
                      'add_friend'.tr,
                          () async{
                        await cubit.sendFriendRequest(user.userId ?? '');
                          }, user.isFriend == true ? AppConstance.warningColor : null,
                    );
                  },
                ),
                ActionButtonWidget(Icons.message_outlined, 'message'.tr, () {
                  // Handle message action
                }, null),
                ActionButtonWidget(Icons.more_horiz, 'more'.tr, () {
                  // Handle more options
                }, null),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
