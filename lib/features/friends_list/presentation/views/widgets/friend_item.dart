import 'package:chat/core/utils/app_assets.dart';
import 'package:chat/core/utils/app_constance.dart';
import 'package:chat/core/utils/app_styles.dart';
import 'package:chat/core/widgets/custom_circular_progress_indicator.dart';
import 'package:chat/core/widgets/custom_icon_button.dart';
import 'package:chat/features/friends_list/presentation/manager/friends_list_cubit/friends_list_cubit.dart';
import 'package:chat/features/friends_list/presentation/manager/friends_list_cubit/friends_list_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/methods/show_confirmation_dialog.dart';
import '../../../data/models/friend_model/friend_model.dart';

class FriendItem extends StatelessWidget {
  final FriendModel friend;

  const FriendItem({super.key, required this.friend});

  @override
  Widget build(BuildContext context) {
    var cubit = context.read<FriendsListCubit>();
    return Card(
      color: AppConstance.primaryColor,
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
          children: [
            CircleAvatar(
              radius: 30,
              backgroundImage:
              (friend.userProfileImage != null && friend.userProfileImage != '')
                  ? NetworkImage(friend.userProfileImage!)
                  : AssetImage(AppAssets.userImage),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                friend.name ?? '',
                style: AppStyles.style13.copyWith(
                  color: Colors.white,
                ),
              ),
            ),

            // Action Buttons
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                BlocBuilder<FriendsListCubit, FriendsListStates>(
                  builder: (context, state) {
                    if(state is DeleteFriendLoadingState){
                      return CustomCircularProgressIndicator();
                    }
                    return CustomIconButton(onPressed: () {
                      showConfirmationDialog(
                        context: context,
                        onConfirm: (){
                          cubit.deleteFriend(friend.id ?? '');
                        },
                      );
                    },
                      icon: Icons.person_remove_alt_1_outlined,
                      color: Colors.white,);
                  },
                ),
                BlocBuilder<FriendsListCubit, FriendsListStates>(
                  builder: (context, state) {
                    if(state is DeleteFriendLoadingState){
                      return CustomCircularProgressIndicator();
                    }
                    return CustomIconButton(onPressed: () {
                      showConfirmationDialog(
                        context: context,
                        onConfirm: (){
                          cubit.blockFriend(friend.id ?? '');
                        },
                      );
                    },
                      icon: Icons.block,
                      color: Colors.white,
                    );
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
