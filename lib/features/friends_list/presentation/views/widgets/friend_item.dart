import 'package:chat/core/utils/app_assets.dart';
import 'package:chat/core/utils/app_constance.dart';
import 'package:chat/core/utils/app_styles.dart';
import 'package:chat/core/widgets/custom_icon_button.dart';
import 'package:flutter/material.dart';
import '../../../data/models/friend_model/friend_model.dart';

class FriendItem extends StatelessWidget {
  final FriendModel friend;

  const FriendItem({super.key, required this.friend});

  @override
  Widget build(BuildContext context) {
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
                CustomIconButton(onPressed: (){}, icon: Icons.person_remove_alt_1_outlined,color: Colors.white,),
                CustomIconButton(onPressed: (){}, icon: Icons.block,color: Colors.white,),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
