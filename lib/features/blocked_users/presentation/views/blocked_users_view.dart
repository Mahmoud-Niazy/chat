import 'package:chat/core/widgets/custom_app_bar.dart';
import 'package:chat/core/widgets/custom_circular_progress_indicator.dart';
import 'package:chat/core/widgets/custom_error_widget.dart';
import 'package:chat/core/widgets/empty_list_widget.dart';
import 'package:chat/features/blocked_users/presentation/manager/blocked_users_cubit/blocked_users_cubit.dart';
import 'package:chat/features/blocked_users/presentation/manager/blocked_users_cubit/blocked_users_states.dart';
import 'package:chat/features/blocked_users/presentation/views/widgets/blocked_user_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

import '../../data/models/blocked_user_model/blocked_user_model.dart';

class BlockedUsersView extends StatelessWidget {
  const BlockedUsersView({super.key});

  @override
  Widget build(BuildContext context) {
    var cubit = context.read<BlockedUsersCubit>();
    return Scaffold(
      appBar: CustomAppBar(title: 'blocked_users'.tr),
      body: BlocBuilder<BlockedUsersCubit, BlockedUsersStates>(
        builder: (context, state) {
          if (state is GetBlockedUsersLoadingState) {
            return const CustomCircularProgressIndicator();
          }
          if(state is BlockedUsersErrorState){
            return CustomErrorWidget();
          }
          List<BlockedUserModel> blockedUsers = cubit.blockedUsers;
          if (blockedUsers.isEmpty) {
            return const EmptyListWidget();
          }
          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: blockedUsers.length,
            itemBuilder: (context, index) {
              return BlockedUserItem(blockedUser: blockedUsers[index]);
            },
          );
        },
      ),
    );
  }
}


