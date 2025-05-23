import 'package:chat/core/widgets/custom_app_bar.dart';
import 'package:chat/core/widgets/custom_circular_progress_indicator.dart';
import 'package:chat/core/widgets/custom_error_widget.dart';
import 'package:chat/core/widgets/empty_list_widget.dart';
import 'package:chat/features/friends_list/presentation/views/widgets/friend_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:chat/features/friends_list/data/models/friend_model/friend_model.dart';
import 'package:chat/features/friends_list/presentation/manager/friends_list_cubit/friends_list_cubit.dart';
import 'package:chat/features/friends_list/presentation/manager/friends_list_cubit/friends_list_states.dart';
import 'package:get/get.dart';

class FriendsListView extends StatelessWidget {
  const FriendsListView({super.key});

  @override
  Widget build(BuildContext context) {
    var cubit =  context.read<FriendsListCubit>();
    return  Scaffold(
      appBar: CustomAppBar(title: 'friends'.tr),
      body:
      BlocBuilder<FriendsListCubit, FriendsListStates>(
        builder: (context, state) {
          if (state is GetFriendsListLoadingState) {
            return CustomCircularProgressIndicator();
          }
          List<FriendModel> friends = cubit.allFriends;
          if (friends.isEmpty) {
            return EmptyListWidget();
          }
          if(state is FriendsListErrorState){
            return CustomErrorWidget();
          }
          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: friends.length,
            itemBuilder: (context, index) {
              return FriendItem(friend: friends[index]);
            },
          );
        },
      ),
    );
  }
}

