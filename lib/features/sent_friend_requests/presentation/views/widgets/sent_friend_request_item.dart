import 'package:chat/core/utils/app_assets.dart';
import 'package:chat/core/utils/app_constance.dart';
import 'package:chat/core/utils/app_styles.dart';
import 'package:chat/core/widgets/custom_circular_progress_indicator.dart';
import 'package:chat/core/widgets/custom_icon_button.dart';
import 'package:chat/features/sent_friend_requests/data/models/sent_friend_request_model/sent_friend_request_model.dart';
import 'package:chat/features/sent_friend_requests/presentation/manager/sent_friend_requests_cubit/sent_friend_requests_cubit.dart';
import 'package:chat/features/sent_friend_requests/presentation/manager/sent_friend_requests_cubit/sent_friend_requests_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/methods/show_confirmation_dialog.dart';

class SentRequestItem extends StatelessWidget {
  final SentFriendRequestModel request;

  const SentRequestItem({super.key, required this.request});

  @override
  Widget build(BuildContext context) {
    var cubit = context.read<SentFriendRequestsCubit>();
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
              (request.userProfileImage != null &&
                  request.userProfileImage != '')
                  ? NetworkImage(request.userProfileImage!)
                  : const AssetImage(AppAssets.userImage) as ImageProvider,
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(request.name ?? '', style: AppStyles.style17),
                ],
              ),
            ),
            BlocBuilder<SentFriendRequestsCubit, SentFriendRequestsStates>(
              builder: (context, state) {
                if(state is RemoveSentFriendRequestLoadingState){
                  return CustomCircularProgressIndicator();
                }
                return CustomIconButton(
                  onPressed: () {
                    showConfirmationDialog(
                        context: context,
                        onConfirm: () {
                          cubit.removeSentFriendRequest(request.id ?? '');
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