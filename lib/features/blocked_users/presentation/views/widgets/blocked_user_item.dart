import 'package:chat/core/utils/app_assets.dart';
import 'package:chat/core/utils/app_constance.dart';
import 'package:chat/core/utils/app_styles.dart';
import 'package:chat/core/widgets/custom_circular_progress_indicator.dart';
import 'package:chat/core/widgets/custom_icon_button.dart';
import 'package:chat/features/blocked_users/data/models/blocked_user_model/blocked_user_model.dart';
import 'package:chat/features/blocked_users/presentation/manager/blocked_users_cubit/blocked_users_cubit.dart';
import 'package:chat/features/blocked_users/presentation/manager/blocked_users_cubit/blocked_users_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/methods/show_confirmation_dialog.dart';

class BlockedUserItem extends StatelessWidget {
  final BlockedUserModel blockedUser;

  const BlockedUserItem({super.key, required this.blockedUser});

  @override
  Widget build(BuildContext context) {
    var cubit = context.read<BlockedUsersCubit>();
    return Card(
      color: Colors.white,
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            CircleAvatar(
              radius: 30,
              backgroundImage:
              (
                  blockedUser.userProfileImage != null &&
                  blockedUser.userProfileImage != '')
                  ? NetworkImage(blockedUser.userProfileImage!)
                  : const AssetImage(AppAssets.userImage) as ImageProvider,
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(blockedUser.name ?? '', style: AppStyles.style17),
                ],
              ),
            ),
            BlocBuilder<BlockedUsersCubit, BlockedUsersStates>(
              builder: (context, state) {
                if(state is UnblockUserLoadingState){
                  return CustomCircularProgressIndicator();
                }
                return CustomIconButton(
                  onPressed: () {
                    showConfirmationDialog(
                        context: context,
                        onConfirm: () {
                          cubit.unblockUser(blockedUser.id ?? '');
                        }
                    );
                  },
                  icon: Icons.close,
                  color: AppConstance.warningColor,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}